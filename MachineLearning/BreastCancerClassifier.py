"""
    Guy Margalit
    Breast Cancer Classifier
"""
# imports
from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
import matplotlib.pyplot as plt


# loading and splitting data
data = load_breast_cancer()
print(data.feature_names)
train_data, test_data, train_ans, test_ans = train_test_split(data.data, data.target, test_size=0.2, random_state=100)

# create X-axis and Y-axis lists
k_list = list(range(1, 101))
accuracies = []

# loop different k
for k in range(1, 101):
    # creating and training a classifier
    classifier = KNeighborsClassifier(n_neighbors=k, weights="distance")
    classifier.fit(train_data, train_ans)

    # add accuracy to list
    accuracies.append(classifier.score(test_data, test_ans))

# plotting
plt.xlabel("k values")
plt.ylabel("accuracy")
plt.title("Breast Cancer Classifier Accuracy")
plt.plot(k_list, accuracies)
plt.show()
