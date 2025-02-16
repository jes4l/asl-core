"""
Ensemble of networks for improved accuracy in deep learning

Dataset: https://www.kaggle.com/datamunge/sign-language-mnist
"""

import os
import random
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Use tensorflow.keras (recommended) instead of standalone keras
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import Sequential, load_model
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Dense, Flatten, Dropout
from sklearn.metrics import accuracy_score, confusion_matrix

# Create directory for saving models if it doesn't exist
if not os.path.exists("saved_models"):
    os.makedirs("saved_models")

# Define epochs for all models.
epochs = 10

# Update paths as needed; here we assume the CSV files are in a "data" folder.
train = pd.read_csv('sign_mnist_train.csv')
test = pd.read_csv('sign_mnist_test.csv')

# Convert datasets to numpy arrays (float32)
train_data = np.array(train, dtype='float32')
test_data = np.array(test, dtype='float32')

# Define class labels for easy interpretation (25 classes)
class_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
               'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
               'U', 'V', 'W', 'X', 'Y']

# Sanity check – plot a random image and its label
i = random.randint(0, train.shape[0] - 1)
plt.figure(figsize=(2,2))
plt.imshow(train_data[i, 1:].reshape((28,28)), cmap='gray')
plt.title(f"Label: {class_names[int(train_data[i, 0])]}")
plt.axis('off')
plt.show()

# Data distribution visualization (optional)
plt.figure(figsize=(8,6))
train['label'].value_counts().plot(kind='bar')
plt.ylabel('Count')
plt.title('Label Distribution')
plt.show()

# Normalize / scale X values
X_train = train_data[:, 1:] / 255.
X_test  = test_data[:, 1:] / 255.

# Convert y to categorical for categorical cross entropy
y_train = train_data[:, 0]
y_train_cat = to_categorical(y_train, num_classes=25)

y_test = test_data[:, 0]
y_test_cat = to_categorical(y_test, num_classes=25)

# Reshape images for the neural network (28x28x1)
X_train = X_train.reshape(X_train.shape[0], 28, 28, 1)
X_test  = X_test.reshape(X_test.shape[0], 28, 28, 1)

#########################################################
# Model 1
model1 = Sequential()
model1.add(Conv2D(32, (3, 3), input_shape=(28,28,1), activation='relu'))
model1.add(MaxPooling2D(pool_size=(2, 2)))
model1.add(Dropout(0.2))
model1.add(Conv2D(64, (3, 3), activation='relu'))
model1.add(MaxPooling2D(pool_size=(2, 2)))
model1.add(Dropout(0.2))
model1.add(Conv2D(128, (3, 3), activation='relu'))
model1.add(MaxPooling2D(pool_size=(2, 2)))
model1.add(Dropout(0.2))
model1.add(Flatten())
model1.add(Dense(128, activation='relu'))
model1.add(Dense(25, activation='softmax'))

model1.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model1.summary()

history1 = model1.fit(X_train, y_train_cat, batch_size=128, epochs=epochs, verbose=1,
                      validation_data=(X_test, y_test_cat))
model1.save('saved_models/model1.h5')

#########################################################
# Model 2
model2 = Sequential()
model2.add(Conv2D(32, (3, 3), input_shape=(28,28,1), activation='relu'))
model2.add(Conv2D(32, (3, 3), activation='relu'))
model2.add(MaxPooling2D(pool_size=(2, 2)))
model2.add(Conv2D(64, (3, 3), activation='relu'))
model2.add(Conv2D(64, (3, 3), activation='relu'))
model2.add(Conv2D(64, (3, 3), activation='relu'))
model2.add(MaxPooling2D(pool_size=(2, 2)))
model2.add(Conv2D(128, (3, 3), activation='relu'))
model2.add(Conv2D(25, (1,1)))  # 1x1 conv for dimension reduction
model2.add(Flatten())
model2.add(Dense(25, activation='softmax'))

model2.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model2.summary()

history2 = model2.fit(X_train, y_train_cat, batch_size=128, epochs=epochs, verbose=1,
                      validation_data=(X_test, y_test_cat))
model2.save('saved_models/model2.h5')

#########################################################
# Model 3
model3 = Sequential()
model3.add(Conv2D(32, (3, 3), input_shape=(28,28,1), activation='relu'))
model3.add(MaxPooling2D(pool_size=(2, 2)))
model3.add(Dropout(0.2))
model3.add(Conv2D(64, (3, 3), activation='relu'))
model3.add(MaxPooling2D(pool_size=(2, 2)))
model3.add(Dropout(0.2))
model3.add(Flatten())
model3.add(Dense(25, activation='softmax'))

model3.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model3.summary()

history3 = model3.fit(X_train, y_train_cat, batch_size=128, epochs=epochs, verbose=1,
                      validation_data=(X_test, y_test_cat))
model3.save('saved_models/model3.h5')

#########################################################################
# Ensemble Predictions

# We can use the models already in memory.
models = [model1, model2, model3]

# Simple average ensemble
preds = [model.predict(X_test) for model in models]
preds = np.array(preds)
summed = np.sum(preds, axis=0)
ensemble_prediction = np.argmax(summed, axis=1)

# Get individual predictions using np.argmax (since predict_classes is deprecated)
prediction1 = np.argmax(model1.predict(X_test), axis=-1)
prediction2 = np.argmax(model2.predict(X_test), axis=-1)
prediction3 = np.argmax(model3.predict(X_test), axis=-1)

accuracy1 = accuracy_score(y_test, prediction1)
accuracy2 = accuracy_score(y_test, prediction2)
accuracy3 = accuracy_score(y_test, prediction3)
ensemble_accuracy = accuracy_score(y_test, ensemble_prediction)

print('Accuracy Score for model1 =', accuracy1)
print('Accuracy Score for model2 =', accuracy2)
print('Accuracy Score for model3 =', accuracy3)
print('Accuracy Score for average ensemble =', ensemble_accuracy)

########################################
# Weighted average ensemble
weights = [0.4, 0.2, 0.4]
weighted_preds = np.tensordot(preds, weights, axes=((0), (0)))
weighted_ensemble_prediction = np.argmax(weighted_preds, axis=1)
weighted_accuracy = accuracy_score(y_test, weighted_ensemble_prediction)

print('Accuracy Score for weighted average ensemble =', weighted_accuracy)

########################################
# Grid search for the best combination of weights
preds_grid = np.array([model.predict(X_test) for model in models])
grid_results = []

# Loop over weights from 0.0 to 0.4 (step 0.1) for each model
for w1 in range(0, 5):
    for w2 in range(0, 5):
        for w3 in range(0, 5):
            wts = [w1/10., w2/10., w3/10.]
            weighted_preds_grid = np.tensordot(preds_grid, wts, axes=((0), (0)))
            grid_pred = np.argmax(weighted_preds_grid, axis=1)
            acc = accuracy_score(y_test, grid_pred)
            grid_results.append({'wt1': wts[0], 'wt2': wts[1], 'wt3': wts[2], 'acc': acc * 100})

df_grid = pd.DataFrame(grid_results)
max_acc_row = df_grid.loc[df_grid['acc'].idxmax()]
print("Max accuracy of", max_acc_row['acc'], "obtained with w1 =", max_acc_row['wt1'],
      "w2 =", max_acc_row['wt2'], "and w3 =", max_acc_row['wt3'])

###########################################################################
# Explore metrics for an ideal weighted ensemble model.
ideal_weights = [0.4, 0.1, 0.2]
ideal_weighted_preds = np.tensordot(preds, ideal_weights, axes=((0), (0)))
ideal_weighted_ensemble_prediction = np.argmax(ideal_weighted_preds, axis=1)
ideal_weighted_accuracy = accuracy_score(y_test, ideal_weighted_ensemble_prediction)
print("Ideal weighted ensemble accuracy =", ideal_weighted_accuracy)

# Display a random test image with its predicted and true label
i = random.randint(0, X_test.shape[0] - 1)
plt.figure(figsize=(3,3))
plt.imshow(X_test[i, :, :, 0], cmap='gray')
plt.title(f"Predicted: {class_names[int(ideal_weighted_ensemble_prediction[i])]}, True: {class_names[int(y_test[i])]}")
plt.axis('off')
plt.show()

# --- Fix for plotting the incorrect prediction fraction ---
# Ensure the confusion matrix includes all 25 classes by passing labels=np.arange(25)
cm = confusion_matrix(y_test, ideal_weighted_ensemble_prediction, labels=np.arange(25))
plt.figure(figsize=(12, 12))
sns.set(font_scale=1.6)
sns.heatmap(cm, annot=True, fmt='d', linewidths=.5)
plt.title("Confusion Matrix")
plt.show()

# Compute fractional incorrect misclassifications per class
cm_sum = np.sum(cm, axis=1)
# Avoid division by zero
cm_sum[cm_sum == 0] = 1
incorr_fraction = 1 - np.diag(cm) / cm_sum

plt.figure(figsize=(12, 6))
plt.bar(np.arange(25), incorr_fraction)  # Now both arrays have length 25
plt.xlabel('True Label')
plt.ylabel('Fraction of Incorrect Predictions')
plt.xticks(np.arange(25), class_names)
plt.title("Fraction of Incorrect Predictions per Class")
plt.show()

# Print per-letter Accuracy
print("\nPer-letter Accuracy:")
for idx, letter in enumerate(class_names):
    total = np.sum(cm[idx])
    acc = (cm[idx, idx] / total) if total > 0 else 0
    print(f"Letter {letter}: {acc * 100:.2f}%")
