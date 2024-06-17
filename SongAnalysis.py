import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load the dataset
df = pd.read_csv('youtube_songs_data.csv')

# Data Cleaning and Preparation
# Handling missing values
df.fillna({'likeCount': 0, 'commentCount': 0, 'favoriteCount': 0, 'tags': ''}, inplace=True)

# Converting publishedAt to datetime
df['publishedAt'] = pd.to_datetime(df['publishedAt'])

# Extracting relevant datetime features
df['publishedYear'] = df['publishedAt'].dt.year
df['publishedMonth'] = df['publishedAt'].dt.month
df['publishedDay'] = df['publishedAt'].dt.day
df['publishedHour'] = df['publishedAt'].dt.hour

# Convert duration from ISO 8601 format to seconds
import isodate

df['duration'] = df['duration'].apply(lambda x: isodate.parse_duration(x).total_seconds())

# Exploratory Data Analysis (EDA)
# Basic statistics
print(df.describe())

# Distribution of view counts
plt.figure(figsize=(10, 6))
sns.histplot(df['viewCount'], bins=50, kde=True)
plt.title('Distribution of View Counts')
plt.xlabel('View Count')
plt.ylabel('Frequency')
plt.show()

# Distribution of like counts
plt.figure(figsize=(10, 6))
sns.histplot(df['likeCount'], bins=50, kde=True)
plt.title('Distribution of Like Counts')
plt.xlabel('Like Count')
plt.ylabel('Frequency')
plt.show()

# Relationship between views, likes, and comments
plt.figure(figsize=(10, 6))
sns.scatterplot(data=df, x='viewCount', y='likeCount', hue='commentCount', palette='viridis')
plt.title('Views vs Likes vs Comments')
plt.xlabel('View Count')
plt.ylabel('Like Count')
plt.legend(title='Comment Count')
plt.show()

# Content and Channel Analysis
# Top channels by number of videos
top_channels = df['channelTitle'].value_counts().head(10)
plt.figure(figsize=(10, 6))
sns.barplot(x=top_channels.values, y=top_channels.index)
plt.title('Top 10 Channels by Number of Videos')
plt.xlabel('Number of Videos')
plt.ylabel('Channel Title')
plt.show()

# Popular tags
tags = df['tags'].str.split('|').explode()
top_tags = tags.value_counts().head(10)
plt.figure(figsize=(10, 6))
sns.barplot(x=top_tags.values, y=top_tags.index)
plt.title('Top 10 Tags')
plt.xlabel('Count')
plt.ylabel('Tags')
plt.show()

# Temporal Trends
# Views over time
df.groupby('publishedYear')['viewCount'].sum().plot(kind='bar', figsize=(10, 6))
plt.title('Total Views by Year')
plt.xlabel('Year')
plt.ylabel('Total Views')
plt.show()

# User Engagement Insights
# Correlation matrix
corr = df[['viewCount', 'likeCount', 'commentCount', 'favoriteCount', 'duration']].corr()
plt.figure(figsize=(10, 6))
sns.heatmap(corr, annot=True, cmap='coolwarm')
plt.title('Correlation Matrix')
plt.show()

# Save cleaned data for Power BI
df.to_csv('cleaned_youtube_songs_data.csv', index=False)
