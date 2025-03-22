import joblib
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.metrics import accuracy_score, silhouette_score
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import StandardScaler

# Step 1: Load CC Transaction Data (Replace with actual dataset path)
data = pd.read_csv("creditcard.csv") # Assuming a CSV file with ECG features

# Step 2: Preprocess the Data
scaler = StandardScaler()
X = scaler.fit_transform(data.iloc[:, :-1])  # Normalize features (excluding label column if present)

# Step 3: Apply K-Means Clustering
k = 2  # Number of clusters (Normal=0, Fraud=1)
kmeans = KMeans(n_clusters=k, random_state=42)
kmeans_labels = kmeans.fit_predict(X)

# Step 4: Train K-Nearest Neighbors (KNN) Classifier
X_train, X_test, y_train, y_test = train_test_split(X, kmeans_labels, test_size=0.2, random_state=42)
knn = KNeighborsClassifier(n_neighbors=2)  # Choose optimal K for KNN
knn.fit(X_train, y_train)

# Step 5: Classify New CC Transaction Data
y_pred = knn.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)

# Step 6: Evaluate Clustering Performance
sil_score = silhouette_score(X, kmeans_labels)
print(f"K-Means + KNN Accuracy: {accuracy * 100:.2f}%")
print(f"Silhouette Score: {sil_score:.2f}")

# Predict on training data
y_train_pared = knn.predict(X_train)

# Calculate training accuracy
train_accuracy = accuracy_score(y_train, y_train_pared)

# Display the results
print(f"Training Accuracy: {train_accuracy * 100:.2f}%")
print(f"Test Accuracy: {accuracy * 100:.2f}%")  # This is already calculated


import matplotlib.pyplot as plt

# Store training and testing accuracy
accuracy_scores = {"Training": train_accuracy * 100, "Testing": accuracy * 100}


# Plot bar chart
plt.figure(figsize=(6, 2))
plt.bar(accuracy_scores.keys(), accuracy_scores.values(), color=['blue', 'green'])

bars = plt.bar(accuracy_scores.keys(), accuracy_scores.values(), color=['blue', 'green'], edgecolor='black')

# Add value labels on top of bars
for bar in bars:
    plt.text(bar.get_x() + bar.get_width() / 2, bar.get_height() - 5, f"{bar.get_height():.2f}%",
             ha='center', color='white', fontsize=12, fontweight='bold')

plt.ylim(0, 100)  # Accuracy is in percentage (0-100)
plt.ylabel("Accuracy (%)")
plt.title("Training vs Testing Accuracy")
plt.show()


from sklearn.metrics import confusion_matrix
import seaborn as sns
import matplotlib.pyplot as plt

# Define class labels
class_labels = ["0", "1"]

# Compute confusion matrix
conf_matrix = confusion_matrix(y_test, y_pred)

# Plot confusion matrix with labels
plt.figure(figsize=(6, 2))
sns.heatmap(conf_matrix, annot=True, fmt='d', cmap='Blues',
            xticklabels=class_labels, yticklabels=class_labels)

plt.xlabel("Predicted Label")
plt.ylabel("True Label")
plt.title("Confusion Matrix")
plt.show()


import pandas as pd

# Convert confusion matrix to DataFrame with labels
conf_matrix_df = pd.DataFrame(conf_matrix, index=class_labels, columns=class_labels)

# Save to CSV file
conf_matrix_df.to_csv("confusion_matrix.csv")

print("Confusion matrix saved to 'confusion_matrix.csv'")

joblib.dump(scaler, "scaler.pkl")
joblib.dump(kmeans, "kmeans_model.pkl")
joblib.dump(knn, "knn_model.pkl")