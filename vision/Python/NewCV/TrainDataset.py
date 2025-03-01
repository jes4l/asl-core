import os
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Flatten, Dense, Dropout, Rescaling
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.callbacks import EarlyStopping

# ===============================
# Parameters and Paths
# ===============================
DATASET_DIR = r'C:\Users\LLR User\Downloads\pointnet_hands-main\pointnet_hands-main\results\mediapipeSkeleton'
IMG_HEIGHT = 200
IMG_WIDTH = 200
BATCH_SIZE = 16
EPOCHS = 50
LEARNING_RATE = 0.001
MODEL_SAVE_PATH = r'C:\Users\LLR User\Desktop\Project\diss\vision\Model\model.h5'

if not os.path.isdir(DATASET_DIR):
    raise FileNotFoundError(f"Dataset directory '{DATASET_DIR}' not found.")

# ===============================
# Data Loading and Preprocessing
# ===============================
# Load training and validation datasets (50/50 split)
train_ds = tf.keras.utils.image_dataset_from_directory(
    DATASET_DIR,
    validation_split=0.5,
    subset="training",
    seed=123,
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

val_ds = tf.keras.utils.image_dataset_from_directory(
    DATASET_DIR,
    validation_split=0.5,
    subset="validation",
    seed=123,
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

# Get class names and number of classes
class_names = train_ds.class_names
num_classes = len(class_names)
print("Detected classes:", class_names)

# Optimize dataset performance
AUTOTUNE = tf.data.AUTOTUNE
train_ds = train_ds.cache().prefetch(buffer_size=AUTOTUNE)
val_ds = val_ds.cache().prefetch(buffer_size=AUTOTUNE)

# ===============================
# Data Augmentation Layer (only applied during training)
# ===============================
data_augmentation = Sequential([
    tf.keras.layers.RandomFlip("horizontal"),
    tf.keras.layers.RandomRotation(0.1),
    tf.keras.layers.RandomZoom(0.1)
])

# ===============================
# Model: Custom CNN Architecture with Augmentation and Normalization
# ===============================
model = Sequential([
    # Input layer with data augmentation and normalization
    tf.keras.layers.Input(shape=(IMG_HEIGHT, IMG_WIDTH, 3)),
    data_augmentation,
    Rescaling(1. / 255),

    # Convolutional block 1
    Conv2D(32, (3, 3), activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2, 2)),

    # Convolutional block 2
    Conv2D(64, (3, 3), activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2, 2)),

    # Convolutional block 3
    Conv2D(128, (3, 3), activation='relu', padding='same'),
    MaxPooling2D(pool_size=(2, 2)),

    # Flatten and Dense layers
    Flatten(),
    Dense(128, activation='relu'),
    Dropout(0.5),  # Regularization to reduce overfitting
    Dense(num_classes, activation='softmax')
])

model.summary()

# ===============================
# Compilation and Training
# ===============================
optimizer = Adam(learning_rate=LEARNING_RATE)
model.compile(optimizer=optimizer,
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# EarlyStopping callback to halt training when validation loss stops improving
early_stop = EarlyStopping(monitor='val_loss', patience=5, restore_best_weights=True)

history = model.fit(
    train_ds,
    validation_data=val_ds,
    epochs=EPOCHS,
    callbacks=[early_stop]
)

# ===============================
# Save the Model
# ===============================
model.save(MODEL_SAVE_PATH)
print(f"Model saved to {MODEL_SAVE_PATH}")
