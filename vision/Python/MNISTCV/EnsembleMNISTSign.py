import os
import pandas as pd
import numpy as np
import random
import matplotlib.pyplot as plt
import seaborn as sns

from keras.utils import to_categorical
from keras.models import Sequential, load_model
from keras.layers import Conv2D, MaxPooling2D, Dense, Flatten, Dropout
from sklearn.metrics import accuracy_score, confusion_matrix

if not os.path.exists('saved_models'):
    os.makedirs('saved_models')

epochs = 10

train = pd.read_csv('sign_mnist_train.csv')
test = pd.read_csv('sign_mnist_test.csv')

original_to_letter = {
    0: 'A', 1: 'B', 2: 'C', 3: 'D', 4: 'E', 5: 'F', 6: 'G', 7: 'H', 8: 'I',
    9: 'J', 10: 'K', 11: 'L', 12: 'M', 13: 'N', 14: 'O', 15: 'P', 16: 'Q',
    17: 'R', 18: 'S', 19: 'T', 20: 'U', 21: 'V', 22: 'W', 23: 'X', 24: 'Y'
}

print("Original to New Label Mapping (Excluding 'J'):")
for orig in range(25):
    if orig == 9:
        print(f"Original: {orig} -> Removed (J)")
    else:
        new_label = orig if orig < 9 else orig - 1
        print(f"Original: {orig} -> New: {new_label} -> Letter: {original_to_letter[orig]}")

train = train[train['label'] != 9]
test = test[test['label'] != 9]

train['label'] = train['label'].apply(lambda x: x if x < 9 else x - 1)
test['label'] = test['label'].apply(lambda x: x if x < 9 else x - 1)

class_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
               'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
               'T', 'U', 'V', 'W', 'X', 'Y']

train_data = np.array(train, dtype='float32')
test_data = np.array(test, dtype='float32')

i = random.randint(0, train.shape[0] - 1)
plt.figure(figsize=(2,2))
plt.imshow(train_data[i, 1:].reshape(28, 28), cmap='gray')
plt.title(f"Label: {class_names[int(train_data[i, 0])]}")
plt.show()

plt.figure(figsize=(8,6))
train['label'].value_counts().sort_index().plot(kind='bar')
plt.ylabel('Count')
plt.title('Distribution of Labels in Training Set')
plt.xticks(np.arange(24), class_names, rotation=0)
plt.show()

X_train = train_data[:, 1:] / 255.0
X_test = test_data[:, 1:] / 255.0

y_train = train_data[:, 0]
y_test = test_data[:, 0]
y_train_cat = to_categorical(y_train, num_classes=24)
y_test_cat = to_categorical(y_test, num_classes=24)

X_train = X_train.reshape(-1, 28, 28, 1)
X_test = X_test.reshape(-1, 28, 28, 1)

model1 = Sequential([
    Conv2D(32, (3, 3), input_shape=(28,28,1), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.2),
    Conv2D(64, (3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.2),
    Conv2D(128, (3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.2),
    Flatten(),
    Dense(128, activation='relu'),
    Dense(24, activation='softmax')
])

model1.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model1.summary()

history1 = model1.fit(X_train, y_train_cat, batch_size=128, epochs=epochs,
                      verbose=1, validation_data=(X_test, y_test_cat))
model1.save('saved_models/model1.hdf5')

model2 = Sequential([
    Conv2D(32, (3, 3), input_shape=(28,28,1), activation='relu'),
    Conv2D(32, (3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Conv2D(64, (3, 3), activation='relu'),
    Conv2D(64, (3, 3), activation='relu'),
    Conv2D(64, (3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Conv2D(128, (3, 3), activation='relu'),
    Conv2D(24, (1, 1)),
    Flatten(),
    Dense(24, activation='softmax')
])

model2.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model2.summary()

history2 = model2.fit(X_train, y_train_cat, batch_size=128, epochs=epochs,
                      verbose=1, validation_data=(X_test, y_test_cat))
model2.save('saved_models/model2.hdf5')

model3 = Sequential([
    Conv2D(32, (3, 3), input_shape=(28,28,1), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.2),
    Conv2D(64, (3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Dropout(0.2),
    Flatten(),
    Dense(24, activation='softmax')
])

model3.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc'])
model3.summary()

history3 = model3.fit(X_train, y_train_cat, batch_size=128, epochs=epochs,
                      verbose=1, validation_data=(X_test, y_test_cat))
model3.save('saved_models/model3.hdf5')

model1 = load_model('saved_models/model1.hdf5')
model2 = load_model('saved_models/model2.hdf5')
model3 = load_model('saved_models/model3.hdf5')
models = [model1, model2, model3]

preds = [model.predict(X_test) for model in models]
preds = np.array(preds)
summed = np.sum(preds, axis=0)
ensemble_prediction = np.argmax(summed, axis=1)

prediction1 = np.argmax(model1.predict(X_test), axis=-1)
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

weights = [0.4, 0.2, 0.4]
weighted_preds = np.tensordot(preds, weights, axes=((0), (0)))
weighted_ensemble_prediction = np.argmax(weighted_preds, axis=1)
weighted_accuracy = accuracy_score(y_test, weighted_ensemble_prediction)

print('Weighted ensemble accuracy = ', weighted_accuracy)

df = pd.DataFrame(columns=['wt1', 'wt2', 'wt3', 'acc'])
for w1 in range(0, 5):
    for w2 in range(0, 5):
        for w3 in range(0, 5):
            wts = [w1 / 10., w2 / 10., w3 / 10.]
            wted_preds = np.tensordot(preds, wts, axes=((0), (0)))
            wted_ensemble_pred = np.argmax(wted_preds, axis=1)
            weighted_accuracy = accuracy_score(y_test, wted_ensemble_pred)
            df = pd.concat([df, pd.DataFrame({'wt1': wts[0],
                                               'wt2': wts[1],
                                               'wt3': wts[2],
                                               'acc': weighted_accuracy * 100}, index=[0])],
                           ignore_index=True)

max_acc_row = df.iloc[df['acc'].idxmax()]
print("Max accuracy of {:.2f}% obtained with w1 = {}, w2 = {}, and w3 = {}"
      .format(max_acc_row['acc'], max_acc_row['wt1'], max_acc_row['wt2'], max_acc_row['wt3']))

ideal_weights = [0.4, 0.1, 0.2]
ideal_weighted_preds = np.tensordot(preds, ideal_weights, axes=((0), (0)))
ideal_weighted_ensemble_prediction = np.argmax(ideal_weighted_preds, axis=1)
ideal_weighted_accuracy = accuracy_score(y_test, ideal_weighted_ensemble_prediction)
print("Ideal weighted ensemble accuracy: ", ideal_weighted_accuracy)

i = random.randint(0, len(ideal_weighted_ensemble_prediction) - 1)
plt.figure(figsize=(2,2))
plt.imshow(X_test[i, :, :, 0], cmap='gray')
plt.title(f"Predicted: {class_names[int(ideal_weighted_ensemble_prediction[i])]}, True: {class_names[int(y_test[i])]}")
plt.show()

cm = confusion_matrix(y_test, ideal_weighted_ensemble_prediction)
plt.figure(figsize=(12,12))
sns.heatmap(cm, annot=True, fmt="d", linewidths=.5, cmap='Blues')
plt.title("Confusion Matrix")
plt.xlabel("Predicted Label")
plt.ylabel("True Label")
plt.show()

incorr_fraction = 1 - np.diag(cm) / np.sum(cm, axis=1)
plt.figure(figsize=(12,6))
plt.bar(np.arange(24), incorr_fraction)
plt.xlabel('True Label')
plt.ylabel('Fraction of Incorrect Predictions')
plt.xticks(np.arange(24), class_names)
plt.title("Fractional Incorrect Predictions per Class")
plt.show()
