import streamlit as st
import pandas as pd
import joblib
import matplotlib.pyplot as plt
import seaborn as sns

# Load trained models
scaler = joblib.load("scaler.pkl")
kmeans = joblib.load("kmeans_model.pkl")
knn = joblib.load("knn_model.pkl")

# Class labels
class_labels = ["Normal", "Fraud"]

# Streamlit UI
st.title("Credit Card Transaction Fraud Classification Dashboard")
st.write("Upload an Credit Card Transaction  dataset to classify using the trained K-Means + KNN model.")

# File uploader
uploaded_file = st.file_uploader("Upload Credit Card Transaction CSV file", type=["csv"])

if uploaded_file:
    # Read uploaded data
    data = pd.read_csv(uploaded_file)

    # Display uploaded data
    st.subheader("Uploaded Data Preview")
    st.write(data.head())

    # Preprocess data (Assume last column is a label if present)
    X_new = scaler.transform(data.iloc[:, :-1]) if data.shape[1] > 1 else scaler.transform(data)

    # Predict with K-Means + KNN
    cluster_labels = kmeans.predict(X_new)
    predictions = knn.predict(X_new)

    # Convert predictions to class labels
    classified_labels = [class_labels[p] for p in predictions]

    # Show predictions
    st.subheader("Predictions")
    prediction_df = pd.DataFrame({"Cluster": cluster_labels, "Predicted Class": classified_labels})
    st.write(prediction_df)

    # Plot cluster distribution
    st.subheader("Cluster Distribution")
    cluster_counts = pd.Series(cluster_labels).value_counts()
    plt.figure(figsize=(6, 4))
    sns.barplot(x=cluster_counts.index, y=cluster_counts.values, palette="viridis")

    ax = sns.barplot(
        x=cluster_counts.index,
        y=cluster_counts.values,
        palette="viridis",
        edgecolor="black",
        order=sorted(cluster_counts.index),
    )

    # Add value labels on top of bars
    for container in ax.containers:
        ax.bar_label(container, fmt='%d', label_type='edge', fontsize=10, padding=3)

    plt.xlabel("Cluster Label")
    plt.ylabel("Count")
    plt.title("Cluster Distribution in Uploaded Data")
    st.pyplot(plt)

    # Save results
    prediction_df.to_csv("CC_predictions.csv", index=False)
    st.success("Predictions saved to 'CC_predictions.csv'")