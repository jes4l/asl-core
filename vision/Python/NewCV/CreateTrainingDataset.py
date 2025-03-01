import os
import shutil

# Set your source and destination directories.
SOURCE_DIR = r"C:\Users\LLR User\Desktop\mediapipeSkeleton"
DEST_DIR = r"C:\Users\LLR User\Desktop\mediapipeSkeletonTest"
TARGET_COUNT = 1276

# Create the destination directory if it doesn't exist.
if not os.path.exists(DEST_DIR):
    os.makedirs(DEST_DIR)

# Loop through each folder in the source directory.
for folder in os.listdir(SOURCE_DIR):
    source_folder = os.path.join(SOURCE_DIR, folder)
    dest_folder = os.path.join(DEST_DIR, folder)

    # Process only directories.
    if os.path.isdir(source_folder):
        os.makedirs(dest_folder, exist_ok=True)
        # List all files in the current folder.
        files = [f for f in os.listdir(source_folder) if os.path.isfile(os.path.join(source_folder, f))]

        # Check if the folder contains at least TARGET_COUNT files.
        if len(files) < TARGET_COUNT:
            print(f"Warning: Folder '{folder}' has only {len(files)} files. Copying all available files.")
            selected_files = files
        else:
            # Sort files alphabetically for reproducibility (or use random.sample for a random selection)
            files.sort()
            selected_files = files[:TARGET_COUNT]

        # Copy each selected file to the destination folder.
        for file in selected_files:
            src_file = os.path.join(source_folder, file)
            dst_file = os.path.join(dest_folder, file)
            shutil.copy2(src_file, dst_file)

        print(f"Copied {len(selected_files)} files to folder: {dest_folder}")
