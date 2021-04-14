#include <iostream>
#include <cstring>
#include <fstream>
#include <boost/mpl/void.hpp>
using namespace std;

int nb = 3;
void ecrireDonnes(char nomFichier[] ){
     ofstream myfile;
  myfile.open (nomFichier);
  for (int i=0; i<nb;i++){
      int x;
      cin >> x;
  myfile << x<<endl;
}
  myfile.close();
    
}


void lireeDonnes(char nomFichier[] , int T[] ){
    
       fstream in;
       in.open(nomFichier);
       int element;

       if (in.is_open()) {
           int i = 0;
           while (in >> element) {
               T[i++] = element;
           }
       }

       in.close();   
}

void aficheTableau( int T[]  , int nb ){
            for(int c=0; c<nb; c++) {
            cout << T[c] << " ";
        }
    
}

void triSelection( int T[]  , int nb ){
        int i, min, j;

    for (i = 0; i < nb - 1; ++i)
    {
        min = i;
        for (j = i + 1; j < nb; ++j)
        {
            if (T[j] < T[min])
            {
                min = j;
            }
        }
        if (min != i)
        {
            std::swap(T[i], T[min]);
        }
    }
    
}

void enregistrerDonnes(char nomFichier[] , int T[]  , int nb){
  ofstream myfile;
  myfile.open (nomFichier);
  for (int i=0; i<nb;i++){

  myfile << T[i]<< endl;
}
  myfile.close();
    
}




int main() {
char nomFichier[] = "test.txt";
int T[nb] ;
    
 ecrireDonnes( nomFichier );

 lireeDonnes( nomFichier ,  T );

 aficheTableau(  T  ,  nb );


 triSelection(  T  ,  nb );


 enregistrerDonnes( nomFichier ,  T  ,  nb);
    
}



