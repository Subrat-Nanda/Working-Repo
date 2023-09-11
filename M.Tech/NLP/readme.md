# NLP (Natural Language Processing)

---------------------------------------------------------------

**Table of Contents**
1.	What are Corpus, Tokens, and Engrams?
2.	What is Tokenization?
o	What is White-space Tokenization?
o	What is Regular Expression Tokenization?
3.	What is Normalization?
o	What is Stemming?
o	What is Lemmatization?
4.	Part of Speech tags in NLP
5.	Grammar in NLP and its types
o	What is Constituency Grammar?
o	What is Dependency Grammar?

Natural Language Processing or NLP refers to the branch of Artificial Intelligence that gives the machines the ability to read, understand and derive meaning from human languages.

What are Corpus, Tokens, and Engrams?
A Corpus is defined as a collection of text documents for example a data set containing news is a corpus or the tweets containing Twitter data is a corpus. So corpus consists of documents, documents comprise paragraphs, paragraphs comprise sentences and sentences comprise further smaller units which are called Tokens.

Basics of Natural Language Processing Corpus, Tokens, and Engrams

Tokens can be words, phrases, or Engrams, and Engrams are defined as the group of n words together.

For example, consider this given sentence-

“I love my phone.”

In this sentence, the uni-grams(n=1) are: I, love, my, phone

Di-grams(n=2) are: I love, love my, my phone

And tri-grams(n=3) are: I love my, love my phone

So, uni-grams are representing one word, di-grams are representing two words together and tri-grams are representing three words together.

 

2. What is Tokenization?
Let’s discuss Tokenization now. Tokenization is a process of splitting a text object into smaller units which are also called tokens. Examples of tokens can be words, numbers, engrams, or even symbols. The most commonly used tokenization process is White-space Tokenization.

 

2.1 What is White-space Tokenization?
Also known as unigram tokenization. In this process, the entire text is split into words by splitting them from white spaces.

For example, in a sentence- “I went to New-York to play football.”

This will be splitted into following tokens: “I”, “went”, “to”, “New-York”, “to”, “play”, “football.”

Notice that “New-York” is not split further because the tokenization process was based on whitespaces only.

 

2.2 What is Regular Expression Tokenization?
The other type of tokenization process is Regular Expression Tokenization, in which a regular expression pattern is used to get the tokens. For example, consider the following string containing multiple delimiters such as comma, semi-colon, and white space.

Sentence= “Football, Cricket; Golf Tennis"

re.split(r’[;,\s]’, Sentence
Tokens= “Football”, ”Cricket”, “Golf”, “Tennis”

Using Regular expression, we can split the text by passing a splitting pattern.

Tokenization can be performed at the sentence level or at the world level or even at the character level.

3. What is Normalization?
The next technique is Normalization. In the field of linguistics and NLP, a Morpheme is defined as the base form of a word. A token is generally made up of two components, Morphemes, which are the base form of the word, and Inflectional forms, which are essentially the suffixes and prefixes added to morphemes.

Basics of Natural Language Processing normalization

For example, consider the word Antinationalist,

Basics of Natural Language Processing example

which is made up of Anti and ist as the inflectional forms and national as the morpheme. Normalization is the process of converting a token into its base form. In the normalization process, the inflection from a word is removed so that the base form can be obtained. So, the normalized form of anti-nationalist is national.

Normalization is useful in reducing the number of unique tokens present in the text, removing the variations of a word in the text, and removing redundant information too. Popular methods which are used for normalization are Stemming and Lemmatization.

Let’s discuss them in detail!

 

3.1 What is Stemming?
Stemming is an elementary rule-based process for removing inflectional forms from a token and the outputs are the stem of the world.

For example, “laughing”, “laughed“, “laughs”, “laugh” will all become “laugh”, which is their stem, because their inflection form will be removed.

Basics of Natural Language Processing stemming

Stemming is not a good normalization process because sometimes stemming can produce words that are not in the dictionary. For example, consider a sentence: “His teams are not winning”

After stemming the tokens that we will get are- “hi”, “team”, “are”, “not”,  “winn”

Notice that the keyword “winn” is not a regular word and “hi” changed the context of the entire sentence.

Another example could be-

Basics of Natural Language Processing table

 

3.2 What is Lemmatization?
Lemmatization, on the other hand, is a systematic step-by-step process for removing inflection forms of a word. It makes use of vocabulary, word structure, part of speech tags, and grammar relations.

The output of lemmatization is the root word called a lemma. For example,

Am, Are, Is >> Be

Running, Ran, Run >> Run

Also, since it is a systematic process while performing lemmatization one can specify the part of the speech tag for the desired term and lemmatization will only be performed if the given word has the proper part of the speech tag. For example, if we try to lemmatize the word running as a verb, it will be converted to run. But if we try to lemmatize the same word running as a noun it won’t be converted.

A detailed explanation of how Lemmatization works by the step-by-step process to remove inflection forms of a word-

lemmetization

Let us now look at some of the syntax and structure-related properties of text objects. We will be talking about the part of speech tags and grammar.

 

4. Part of Speech(PoS) Tags in Natural Language Processing-
Part of Speech(PoS)

Part of speech tags or PoS tags is the properties of words that define their main context, their function, and the usage in a sentence. Some of the commonly used parts of speech tags are- Nouns, which define any object or entity; Verbs, which define some action; and Adjectives or Adverbs, which act as the modifiers, quantifiers, or intensifiers in any sentence. In a sentence, every word will be associated with a proper part of the speech tag, for example,

“David has purchased a new laptop from the Apple store.”

In the below sentence, every word is associated with a part of the speech tag which defines their functions.

POS Tag

In this case “David’ has NNP tag which means it is a proper noun, “has” and “purchased” belongs to verb indicating that they are the actions and “laptop” and “Apple store” are the nouns, “new” is the adjective whose role is to modify the context of laptop.

Part of speech tags is defined by the relations of words with the other words in the sentence. Machine learning models or rule-based models are applied to obtain the part of speech tags of a word. The most commonly used part of speech tagging notations is provided by the Penn Part of Speech Tagging.

Part of speech tags have a large number of applications and they are used in a variety of tasks such as text cleaning, feature engineering tasks, and word sense disambiguation. For example, consider these two sentences-

Sentence 1:  “Please book my flight for NewYork”

Sentence 2: “I like to read a book on NewYork”

In both sentences, the keyword “book” is used but in sentence one, it is used as a verb while in sentence two it is used as a noun.

 

5. Grammar in NLP and its types-
Now, let’s discuss grammar. Grammar refers to the rules for forming well-structured sentences. The first type of Grammar is Constituency grammar.

5.1 What is Constituency Grammar?
Any word, group of words, or phrases can be termed as Constituents and the goal of constituency grammar is to organize any sentence into its constituents using their properties. These properties are generally driven by their part of speech tags, noun or verb phrase identification.

For example, constituency grammar can define that any sentence can be organized into three constituents- a subject, a context, and an object.

Constituency Grammar

These constituents can take different values and accordingly can generate different sentences. For example, we have the following constituents-

Constituency Grammar example

Some of the examples of the sentences that can be generated using these constituents are-

“The dogs are barking in the park.”

“They are eating happily.”

“The cats are running since morning.”

Another view to look at constituency grammar is to define their grammar in terms of their part of speech tags. Say a grammar structure containing a [determiner, noun] [ adjective, verb] [preposition, determiner, noun] which corresponds to the same sentence- “The dogs are barking in the park.”

output

5.2 What is Dependency Grammar?
A different type of grammar is Dependency Grammar which states that words of a sentence are dependent upon other words of the sentence. For example, in the previous sentence “barking dog” was mentioned and the dog was modified by barking as the dependency adjective modifier exists between the two.

Dependency grammar organizes the words of a sentence according to their dependencies. One of the words in a sentence acts as a root and all the other words are directly or indirectly linked to the root using their dependencies. These dependencies represent relationships among the words in a sentence and dependency grammars are used to infer the structure and semantics dependencies between the words.

Let’s consider an example. Consider the sentence:

“Analytics Vidhya is the largest community of data scientists and provides the best resources for understanding data and analytics.”

The dependency tree of this sentence looks something like this-

Dependency Grammar

In this tree, the root word is “community” having NN as the part of speech tag and every other word of this tree is connected to root, directly or indirectly, with a dependency relation such as a direct object, direct subject, modifiers, etc.

These relationships define their roles and functions of each word in the sentence and how multiple words are connected together. Every dependency can be represented in the form of a triplet which contains a governor, a relation, and a dependent,

relation

which means that a dependent is connected to the governor by relation, or in other words, they are subject, verb, and object respectively. For example, in the same sentence: “Analytics Vidhya is the largest community of data scientists”

eg

“Analytics Vidhya” is the subject and is playing the role of a governor, the verb here is “is” and is playing the role of the relation, and “the largest community of data scientist” is the dependent or the object.

Dependency grammars can be used in different use case-

Named Entity Recognition– they are used to solve named entity recognition problems.
Question Answering System– they can be used to understand relational and structural aspects of question-answering systems.
Coreference Resolution– they are also used in coreference resolutions in which the task is to map the pronouns to the respective noun phrases.
Text summarization and Text classification– they can also be used for text summarization problems and they are also used as features for text classification problems.
