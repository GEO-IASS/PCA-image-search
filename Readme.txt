Content Based Image Retrieval Using Latent Semantic Indexing
------------------------------------------------------------

Authors:
--------
1) Venkatesh D. 		10IT102		venkybajal@gmail.com		
2) Sambhrum I. G. 		10IT84		sambhrumig@gmail.com	
3) Pradeep P. 			10IT60		pradeep.paul92@gmail.com
4) Nishanth H. Kottary 		10IT54		kottarynishanth54@gmail.com	

Requirements:
-------------
Matlab R2011a.

Directories:
------------
/report/			Contains report details.
	/latex/			Contains latex files and images.
	/pdf/			Contains the latex files compiled to pdf.
/images/			Folder containing 679 images.
/vectors/			Folder containing all the extracted features
	/reduction/		Folder containing reduced vectors.
	/clustering/		Folder containing clustered vectors. 
/matlab code/			Contains all the code files.
	/clustering/		Contains code for clustering.
	/reduction/		Contains code for reduction techniques.
	/extractors/		Contains code for extracting features.
	/scripts/		Contains code for automated tasks.
	/similarityMatchers 	Contains code for similarity metrics.

Instructions:
-------------
1) Generating Vectors:
- in /images/ folder place the image dataset. (you can download images from "INRIA Holidays Dataset" link: "http://lear.inrialpes.fr/je-gou/data.php".)
- Open the directory /matlab code/scripts/
- Run SaveFeatures.m to extract feature vectors.
- Run SavePCAVectors.m, SaveDualPCAVectors.m and SaveKPCAFeatures.m to generate the reduced vectors.
- Run SaveClusters.m to perform clustering for all the above vectors.

2) Running Application.
- Run /matlab code/GUI.m, this opens GUI application.
- Select similarity metric from drop down menu.
- Select whether to use threshold or not.
- Select whether to use reduced vectors or not.
- If reduced vectors are used then select one among PCA, D-PCA or K-PCA.
- Select whether to use clustering.
- Select number of clusters to look up from drop down box.
- Select the image to use as query.
- Click on retrieve button to get the results.

Frequently Asked Questions:
---------------------------
1) How to change the number of dimensions during reduction ?
- Open the reduction script (SavePCAVectors.m, SaveDualPCAVectors.m and SaveKPCAFeatures.m) and change the variable "dimension".
- Re run the scripts.

2) How to change the order of the kernel in K-PCA ?
- Change the variable "para" in the scripts SaveKPCAFeatures.m and kpcaReduction.m.
- Run the script SaveKPCAFeatures.m

3) Querying with image from external directory gives an error.
- This may be because the query image is not in path, in this case add the image to path.
- The image has to have a numerical filename. For Example "123.jpeg".

4) K-PCA gives me very bad results.
- This is because the "para" variable value in /matlab code/scripts/SaveKPCAFeatures.m is different from the value in /matlab_code/reduction/kpcaReduction.m, they need to be the same.

THANK YOU 