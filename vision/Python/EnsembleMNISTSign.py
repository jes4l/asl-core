"""
Dataset: https://www.kaggle.com/datamunge/sign-language-mnist
"""

import os
import pandas as pd
import numpy as np
import random
import matplotlib.pyplot as plt
from keras.utils import to_categorical

from keras.models import Sequential, load_model
from keras.layers import Input, Conv2D, MaxPooling2D, Dense, Flatten, Dropout
from sklearn.metrics import accuracy_score

# Create directory for saving models if it doesn't exist
if not os.path.exists("saved_models"):
    os.makedirs("saved_models")

# Define epochs for all models.
epochs = 10

train = pd.read_csv('sign_mnist_train.csv')
test = pd.read_csv('sign_mnist_test.csv')

# Datasets as numpy arrays
train_data = np.array(train, dtype='float32')
test_data = np.array(test, dtype='float32')

# Define class labels for easy interpretation
class_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
               'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y']

# Sanity check - plot a few images and labels
i = random.randint(1, train.shape[0])
fig1, ax1 = plt.subplots(figsize=(2, 2))
plt.imshow(train_data[i, 1:].reshape((28, 28)))
print("Label for the image is: ", class_names[int(train_data[i, 0])])

# Data distribution visualization
fig = plt.figure(figsize=(18, 18))
ax1 = fig.add_subplot(221)
train['label'].value_counts().plot(kind='bar', ax=ax1)
ax1.set_ylabel('Count')
ax1.set_title('Label')

# Dataset seems to be fairly balanced.

# Normalize / scale X values
X_train = train_data[:, 1:] / 255.
X_test = test_data[:, 1:] / 255.

# Convert y to categorical if planning on using categorical cross entropy
# No need to do this if using sparse categorical cross entropy
y_train = train_data[:, 0]
y_train_cat = to_categorical(y_train, num_classes=25)

y_test = test_data[:, 0]
y_test_cat = to_categorical(y_test, num_classes=25)

# Reshape for the neural network
X_train = X_train.reshape(X_train.shape[0], 28, 28, 1)
X_test = X_test.reshape(X_test.shape[0], 28, 28, 1)

#########################################################
# Model 1

# Defining the Convolutional Neural Network
model1 = Sequential()
model1.add(Input(shape=(28, 28, 1)))
model1.add(Conv2D(32, (3, 3), activation='relu'))
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

# Training the CNN model1
history1 = model1.fit(X_train, y_train_cat, batch_size=128, epochs=epochs, verbose=1,
                      validation_data=(X_test, y_test_cat))

model1.save('saved_models/model1.keras')

##########################################################
# Model 2

model2 = Sequential()
model2.add(Input(shape=(28, 28, 1)))
model2.add(Conv2D(32, (3, 3), activation='relu'))
model2.add(Conv2D(32, (3, 3), activation='relu'))
model2.add(MaxPooling2D(pool_size=(2, 2)))

model2.add(Conv2D(64, (3, 3), activation='relu'))
model2.add(Conv2D(64, (3, 3), activation='relu'))
model2.add(Conv2D(64, (3, 3), activation='relu'))
model2.add(MaxPooling2D(pool_size=(2, 2)))

model2.add(Conv2D(128, (3, 3), activation='relu'))
model2.add(Conv2D(25, (1, 1)))
model2.add(Flatten())
model2.add(Dense(25, activation='softmax'))

model2.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model2.summary()

history2 = model2.fit(X_train, y_train_cat, batch_size=128, epochs=epochs, verbose=1,
                      validation_data=(X_test, y_test_cat))

model2.save('saved_models/model2.keras')

###################################################################
# Model 3

model3 = Sequential()
model3.add(Input(shape=(28, 28, 1)))
model3.add(Conv2D(32, (3, 3), activation='relu'))
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

model3.save('saved_models/model3.keras')

#########################################################################
### Model average / sum Ensemble
# Simple sum of all outputs / predictions and argmax across all classes

models = [model1, model2, model3]
preds = [model.predict(X_test) for model in models]
preds = np.array(preds)
summed = np.sum(preds, axis=0)

ensemble_prediction = np.argmax(summed, axis=1)

prediction1 = np.argmax(model1.predict(X_test), axis=1)
prediction2 = np.argmax(model2.predict(X_test), axis=-1)
prediction3 = np.argmax(model3.predict(X_test), axis=-1)

accuracy1 = accuracy_score(y_test, prediction1)
accuracy2 = accuracy_score(y_test, prediction2)
accuracy3 = accuracy_score(y_test, prediction3)
ensemble_accuracy = accuracy_score(y_test, ensemble_prediction)

print('Accuracy Score for model1 = ', accuracy1)
print('Accuracy Score for model2 = ', accuracy2)
print('Accuracy Score for model3 = ', accuracy3)
print('Accuracy Score for average ensemble = ', ensemble_accuracy)

########################################
# Weighted average ensemble
models = [model1, model2, model3]
preds = [model.predict(X_test) for model in models]
preds = np.array(preds)
weights = [0.4, 0.2, 0.4]

weighted_preds = np.tensordot(preds, weights, axes=((0), (0)))
weighted_ensemble_prediction = np.argmax(weighted_preds, axis=1)

weighted_accuracy = accuracy_score(y_test, weighted_ensemble_prediction)

print('Accuracy Score for model1 = ', accuracy1)
print('Accuracy Score for model2 = ', accuracy2)
print('Accuracy Score for model3 = ', accuracy3)
print('Accuracy Score for average ensemble = ', ensemble_accuracy)
print('Accuracy Score for weighted average ensemble = ', weighted_accuracy)

########################################
# Grid search for the best combination of w1, w2, w3 that gives maximum accuracy
models = [model1, model2, model3]
preds1 = [model.predict(X_test) for model in models]
preds1 = np.array(preds1)

df = pd.DataFrame([])

for w1 in range(0, 5):
    for w2 in range(0, 5):
        for w3 in range(0, 5):
            wts = [w1 / 10., w2 / 10., w3 / 10.]
            wted_preds1 = np.tensordot(preds1, wts, axes=((0), (0)))
            wted_ensemble_pred = np.argmax(wted_preds1, axis=1)
            weighted_accuracy = accuracy_score(y_test, wted_ensemble_pred)
            new_row = pd.DataFrame({'wt1': [wts[0]], 'wt2': [wts[1]],
                                    'wt3': [wts[2]], 'acc': [weighted_accuracy * 100]})
            df = pd.concat([df, new_row], ignore_index=True)

max_acc_row = df.iloc[df['acc'].idxmax()]
print("Max accuracy of ", max_acc_row.iloc[0], " obtained with w1=", max_acc_row.iloc[1],
      " w2=", max_acc_row.iloc[2], " and w3=", max_acc_row.iloc[3])

###########################################################################
### Explore metrics for the ideal weighted ensemble model.

models = [model1, model2, model3]
preds = [model.predict(X_test) for model in models]
preds = np.array(preds)
ideal_weights = [0.4, 0.1, 0.2]

ideal_weighted_preds = np.tensordot(preds, ideal_weights, axes=((0), (0)))
ideal_weighted_ensemble_prediction = np.argmax(ideal_weighted_preds, axis=1)

ideal_weighted_accuracy = accuracy_score(y_test, ideal_weighted_ensemble_prediction)

i = random.randint(1, len(ideal_weighted_ensemble_prediction))
plt.imshow(X_test[i, :, :, 0])
print("Predicted Label: ", class_names[int(ideal_weighted_ensemble_prediction[i])])
print("True Label: ", class_names[int(y_test[i])])

from sklearn.metrics import confusion_matrix
import seaborn as sns

cm = confusion_matrix(y_test, ideal_weighted_ensemble_prediction, labels=np.arange(25))

fig, ax = plt.subplots(figsize=(12, 12))
sns.set(font_scale=1.6)
sns.heatmap(cm, annot=True, linewidths=.5, ax=ax)

# Compute fractional incorrect misclassifications; safeguard against division by zero.
cm_sum = np.sum(cm, axis=1)
cm_sum[cm_sum == 0] = 1  # Prevent division by zero
incorr_fraction = 1 - np.diag(cm) / cm_sum

fig, ax = plt.subplots(figsize=(12, 12))
plt.bar(np.arange(25), incorr_fraction)  # incorr_fraction has length 25
plt.xlabel('True Label')
plt.ylabel('Fraction of incorrect predictions')
plt.xticks(np.arange(25), class_names)
