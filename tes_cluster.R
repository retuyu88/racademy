library(tidyverse) #tidyverse -> Data Manipulation
library(cluster)#cluster -> Clustering Algorithms
library(factoextra)#factoextra -> Clustering algorithms & visualization

agri <- agriculture #mengimport data agriculture ke dalam object agri
dim(agri)
agri
#mencari tau apakah data harus di normalisasi atau tidak
sum(is.na(agri))
#hasil dari sum 0 , berarti data tidak ada yang hilang
head(agri,10) #menampilkan 10 baris pertama dari tabel agri
distinct(agri)#menampilkan semua baris dari tabel agri

#normalisasi data
dfnorm <- agri # melakukan normalisasi data tabel agri
dfnorm #memanggil data

#menghitung distance matrix denegan euclidean
distance <- get_dist(dfnorm, method = "euclidean" )
#melakukan visualisasi dari distance matrix 
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

#mencari k optimal menggunakan silhouette hasilnya 2
fviz_nbclust(dfnorm, kmeans, method = "silhouette")
#mencari k optimal menggunakan elbow hasilnya 2
fviz_nbclust(dfnorm, kmeans, method = "wss")

#didapatkan 2 sebagai K optimal sehingga
k2 <- kmeans(dfnorm, centers = 2, nstart = 25)
str(k2)
#visualisasi kluster hasil kmeans
fviz_cluster(k2, data = dfnorm)

#informasi yang didapat adalah data agri dapat dikelompokan menjadi 2 jenis yang berbeda berdasarkan metode k means
