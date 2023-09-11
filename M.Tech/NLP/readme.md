# NLP (Natural Language Processing)

---------------------------------------------------------------

###### 1. Natural Language Processing (NLP)
 
Natural language processing (NLP) concerns itself with the interaction between natural human languages and computing devices. NLP is a major aspect of computational linguistics, and also falls within the realms of computer science and artificial intelligence.

 

###### 2. Tokenization
 
Tokenization is, generally, an early step in the NLP process, a step which splits longer strings of text into smaller pieces, or tokens. Larger chunks of text can be tokenized into sentences, sentences can be tokenized into words, etc. Further processing is generally performed after a piece of text has been appropriately tokenized.

 

###### 3. Normalization
 
Before further processing, text needs to be normalized. Normalization generally refers to a series of related tasks meant to put all text on a level playing field: converting all text to the same case (upper or lower), removing punctuation, expanding contractions, converting numbers to their word equivalents, and so on. Normalization puts all words on equal footing, and allows processing to proceed uniformly.

 

###### 4. Stemming
 
Stemming is the process of eliminating affixes (suffixed, prefixes, infixes, circumfixes) from a word in order to obtain a word stem.

 
running → run
 

###### 5. Lemmatization
 
Lemmatization is related to stemming, differing in that lemmatization is able to capture canonical forms based on a word's lemma.

For example, stemming the word "better" would fail to return its citation form (another word for lemma); however, lemmatization would result in the following:

 
                                                 better → good

 
It should be easy to see why the implementation of a stemmer would be the less difficult feat of the two.

 

###### 6. Corpus
 
In linguistics and NLP, corpus (literally Latin for body) refers to a collection of texts. Such collections may be formed of a single language of texts, or can span multiple languages -- there are numerous reasons for which multilingual corpora (the plural of corpus) may be useful. Corpora may also consist of themed texts (historical, Biblical, etc.). Corpora are generally solely used for statistical linguistic analysis and hypothesis testing.

 

###### 7. Stop Words
 
Stop words are those words which are filtered out before further processing of text, since these words contribute little to overall meaning, given that they are generally the most common words in a language. For instance, "the," "and," and "a," while all required words in a particular passage, don't generally contribute greatly to one's understanding of content. As a simple example, the following panagram is just as legible if the stop words are removed:


                                         <s>The<s> quick brown fox jumps over <s>the<s> lazy dog.

###### 8. Parts-of-speech (POS) Tagging
 
POS tagging consists of assigning a category tag to the tokenized parts of a sentence. The most popular POS tagging would be identifying words as nouns, verbs, adjectives, etc.

![image](https://github.com/Subrat-Nanda/Working-Repo/assets/77000640/fab5a592-2cf8-43ff-be6b-edef85a35505)

###### 9. Statistical Language Modeling
 
Statistical Language Modeling is the process of building a statistical language model which is meant to provide an estimate of a natural language. For a sequence of input words, the model would assign a probability to the entire sequence, which contributes to the estimated likelihood of various possible sequences. This can be especially useful for NLP applications which generate text.

 

10. Bag of Words
 
Bag of words is a particular representation model used to simplify the contents of a selection of text. The bag of words model omits grammar and word order, but is interested in the number of occurrences of words within the text. The ultimate representation of the text selection is that of a bag of words (bag referring to the set theory concept of multisets, which differ from simple sets).

Actual storage mechanisms for the bag of words representation can vary, but the following is a simple example using a dictionary for intuitiveness. Sample text:

 
                           "Well, well, well," said John.
                           "There, there," said James. "There, there."

The resulting bag of words represents a dictionary:

   {
      'well': 3,
      'said': 2,
      'john': 1,
      'there': 4,
      'james': 1
   }


 

11. n-grams
 
n-grams is another representation model for simplifying text selection contents. As opposed to the orderless representation of bag of words, n-grams modeling is interested in preserving contiguous sequences of N items from the text selection.

An example of trigram (3-gram) model of the second sentence of the above example ("There, there," said James. "There, there.") appears as a list representation below:

   [
      "there there said",
      "there said james",
      "said james there",
      "james there there",
   ]


 

12. Regular Expressions
 
Regular expressions, often abbreviated regexp or regexp, are a tried and true method of concisely describing patterns of text. A regular expression is represented as a special text string itself, and is meant for developing search patterns on selections of text. Regular expressions can be thought of as an expanded set of rules beyond the wildcard characters of ? and *. Though often cited as frustrating to learn, regular expressions are incredibly powerful text searching tools.
