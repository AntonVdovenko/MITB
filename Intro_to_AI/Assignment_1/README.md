

**Assignment 1 -- Introduction to AI** 

**Note:** Your solution for this assignment should have two parts---a pdf document and code files. 

- Have  a  **single**  pdf  document  that  shows  your  solution  for  different  questions  (show  either numerical values if the question asks for it, and/or theoretical justification as required). Include in this pdf, the code you wrote for the solution for the respective question (if coding is required).  
- Upload your real code files that you used to solve the particular question. Make sure your code is neatly organized per question, runs correctly, and has comments that highlight the part you implemented so that your TA can easily understand it 
- Combine your solution pdf and code files in a single zip folder and upload it on the eLearn assignment folder 
- Solution should be typeset using a profession software (word, keynote, latex etc). Figures should also be made using software such as power point. **No handwritten solutions are allowed, and will not be graded.** 

**Question 1 [10 points]:**

Consider the following Bayesian network:  

B A

C D E F

G

Write True/False for the following conditional independence statements. Justify clearly your answer. For example, show the active/blocked trails as necessary and the reason for them to be active or blocked (e.g., use rules such as cascade, common cause or v-structure). [No coding required for this question. Each sub- part has **2 points**] 

1. C ⊥ F |{E,G} 
1. C ⊥ F |{D, G} 
1. E ⊥ D |B 
1. E ⊥ D |{} 
1. A ⊥ F |{C, D} 

**Question 2 [10 points]** 

A box contains three different dices. Each dice has 4 faces with numbers 1 through 4 written over them. The properties of the dices are as follows: 

- Dice 1 (say D1) is a fair dice with each face equally likely to come. 
- Dice 2 (say D2) is a biased dice with outcome 1 likely with probability 0.5. The rest of the outcomes have equal probability (i.e., P(D2=2) = P(D2=3) = P(D2=4) ). 
- Dice 3 (say D3) is also a biased dice with outcome 2 likely with probability 0.5. The rest of the outcomes have equal probability of coming up. 

We pick one dice randomly (that is, each of the dice in the box has equal chance of being picked up), and then that dice is rolled three times to generate outcomes X1, X2 and X3.  

(i)  Draw the Bayes net corresponding to this setup. Explain what each random variable of this Bayes represents, and show the domain of each random variable **[3 points]** 

**Hint:** There should be 4 random variables. 

Draw Bayesian Net Below 



|**Variable Name** |**Domain (Set of Values)** |<p>**Interpretation** *(intuitive explanation of what the variable* </p><p>*represents)*</p>|
| - | - | :- |
||||
||||
||||
||||
(ii) Write conditional probabilities (numerical values) associated with each node of this Bayes 

net. As there are 4 variables, please specify one conditional  probability table (CPT) for each variable **[3 points]** 

CPT for variable 1  CPT for variable 2 

CPT for variable 3  CPT for variable 4 

(iii) Assume that the observed outcome was X1=1, X2=3, X3=2. Calculate which dice (D1 or D2 

or D3) was most likely to have been picked from the box. Show numerical calculations (based on conditional probabilities) to justify your answer (do not use pgmpy to just write the final answer). **[4 points]** 

**Question 3 [10 points]** 

In this question below, we will construct a small Bayesian network in the pgmpy toolbox. This network models the relationship between *yellow fingers*, *smoking*, *cancer*, *weakness*, *radiation*, *solar flares*, and using a *microwave*. In this model, smoking can cause yellow fingers, weakness and cancer. Solar flares and making microwave popcorn can cause radiation, and radiation can cause cancer.  

Consider “0” represents variable is false, “1” represents variable is true. Each variable in this problem is binary or can only take two values (0 or 1). 

The prior probability of smoking P(S=1) is 0.15. The prior probability of solar flares P(F=1) is 0.01. The prior probability of using the microwave P(M=1) is 0.95. 

Conditional probabilities for weakness are given below: S  P(W=1) 

0  0.2 

1  0.9 

Conditional probabilities for radiation are given below: F M P(R=1) 

0  0   0.1 

0  1   0.2 

1  0   0.2 

1  1   0.9 

Conditional probabilities table for cancer are given as: S  R P(C=1) 

0  0   0.1 

0  1   0.6 

1  0   0.3 

1  1   0.9 

The conditional probability table for yellow fingers is given as: S  P(Y=1) 

0  0.11 

1  0.8 

Implement the above Bayes net with the specified conditional probabilities into pgmpy (Install it from http://pgmpy.org/).  

**Print out your code showing the implementation in pgmpy and attach as part of your solution pdf**. [**2.5 points**] 

Answer the following questions. You can use functions implemented in pgmpy to compute the numerical answers as required for some of the below questions. Show also snippets of your code used. [Each sub-part has **1.5 points**] 

1. Draw the Bayesian network clearly showing the nodes and arrows showing relationship among all the variables (you can use drawing tools in PowerPoint or Keynote) 
1. What is the probability of cancer given weakness = 1? 
1. What is the probability of smoking given cancer=1? 
1. Are Smoking and Radiation independent given cancer? Justify your answer. 
1. What is the probability of cancer if you never use a microwave? 

**Question 4 [10 points]** 

In this question, you will create an artificial neural based classifier to classify the **fashion\_mnist** dataset which is available at https://www.tensorflow.org/api\_docs/python/tf/keras/datasets. More details about this dataset are here: https://github.com/zalandoresearch/fashion-mnist. 

You can build your solution on top of the python notebook covered in class to classify the standard fashion\_MNIST dataset. The solution you provide should perform the following tasks: 

1) Download the fashion\_mnist dataset (you can use tf.keras.datasets as covered in class). **[1 point]** 
1) Create an ANN with 1 input layer, **at least** two hidden layer with at least 10 nodes per layer. You can use relu or any other activation function for hidden layers. You are free to create additional hidden layers or increase the number of nodes to maximize the final accuracy (it would require some trial and error). **[3 points]** 
1) Create 1 output layer. What is the size of output layer? What should be the activation function for output layer? **[2 points]** 
1) Compile and train the neural network with the appropriate loss function (what should be the loss function type?) **[2 points]** 

For each of the above parts, also **show the relevant code snippets** in your solution pdf.  

5) What is the final accuracy on the testing data? **[2 points]** 

For this question, please limit yourselves to using dense ANNs (rather than using advanced CNNs). 

**Question 5 [10 points]** 

In this question, we will explore transfer learning in the context of CNNs. More hints to solve this question are at: https://www.tensorflow.org/tutorials/images/transfer\_learning 

You will need to use a pre-trained network (MobileNetV2) to do image classification on the CIFAR-10 dataset (more on the dataset here https://www.cs.toronto.edu/~kriz/cifar.html). We have provided you a code skeleton (skeletonCode.ipynb) to help you finish this problem.  You are free to change this file as required.  

Your solution must do the below tasks: 

1) Download the pre-trained MobileNetV2 network from Keras Applications (https://keras.io/applications/ ) **[1 point]** 
1) Remove the final output layer of the downloaded network (to do this, please check the flag “include\_top” in Keras) **[1 point]** 
1) After removing the final output layer, extend the MobileNetV2 model by adding at least one hidden layer (dense, convolution or any other type of layer). Also attach one final output layer. In this part, you are free to explore and decide how many hidden layers to add, their type, the number of nodes in each layer and the activation function yourself. 

Keep in mind, output layer must have number of nodes and activation function that matches the given task. **[2 points]** 

4) Add the appropriate loss function, compile and train the modified network from part c) to classify the CIFAR-10 dataset. You can either fix the weights of the downloaded MobileNetV2 model and train only the layers you have added, or train the whole network again. Choose the setting that gives you higher accuracy given the computational resources. Check link https://keras.io/getting-started/faq/#how-can-i- freeze-keras-layers. **[2 points]** 

Try to design your CNN so that you achieve 85% accuracy or more on the test data. 

For each part (a)-(d), **copy and paste the code snippets** in your solution pdf that shows how you’re doing the particular tasks.  

Show also the following results in your solution pdf: 

1) Write how you extended the MobileNetV2 model (how many layers you added, what type of layers, how many nodes per layer, their activation function etc). **[2 points]** 
1) Plot the loss function value with respect to the epoch number on the training data. How did you decide when to terminate training? **[1 point]** 
1) Show the accuracy of the trained classifier over the entire testing dataset. **[1 point]** 

Also  attach  the  complete  code  file  as  part  of  your  zip  file.  The  code  should  be  well commented, correctly compiles, and should produce the required outputs. 

Please use tensorflow and Keras libraries for this question (rather than pytorch or other deep learning packages) as our testing setup has only these environments. You may have to install opencv package also for doing some image processing for this question (opencv should be already installed if you use Google Collab). 

**Programming hints**: Make sure to save your network’s parameters while training every once in a while (find out how you can do it in Keras). That way if your program crashes, you don’t have to re-train from scratch. How many epochs are sufficient for convergence? You may need to enter some threshold condition so that training stops when that condition is satisfied. It is not good (or necessary) to train your network until the loss is zero (that may never happen). Furthermore, this may overfit the training dataset, and may lead to poor accuracy on the testing dataset. 

**Useful pointers for running on Colab:** 

1. Note that resizing the training and testing images will consume a relatively large amount of RAM. Please make sure the usage of memory is low before running your program otherwise your program may crash. What you can do is to restart runtime (*Runtime- >Restart runtime*) before running your program. 
1. To use GPU for training, you will need to enable GPUs for the notebook (*Runtime- >Change runtime type->Hardware accelerator->GPU*). Please change the runtime type to CPU when you are not using GPU resources as GPUs will be prioritized for users who have recently used less resources. 
