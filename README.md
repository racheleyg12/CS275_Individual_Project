# CS275_Individual_Project
UITableView of Pokémon modeling the Pokédex, in a contact list format.

Description of Model:  
I would like to make a UITableView of Pokémon.  
It would kinda be like a contact list of the Pokédex.  
(The Pokédex is a list of all the Pokemon and their traits.)
Each Item (from Creating the Item Class in the textbook) would represent a Pokemon. It will have 7 properties:  
var name: String  
var type: String  
var number: Int  
var generation: Int  
var gender: String?  
var weight: Double  
var height: Double  
  
Example: The pokémon—Pikachu  
name = “Pikachu”  
type = “Electric”   
number = 25   
generation = 1   
gender = “male/female”  
Weight = 10.2 //in kg  
Height = 1.04  //in m  
   
//Some Pokemon do not have genders  
//it’s index out of all 800+ pokemon  
Still have to add:  
Section headers for generation which Pokemon come from.  
Make text input not case sensitive  
