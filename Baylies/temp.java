class Datcon 
    Datcon parent
    Datcon[] children 
    level       //properties
    
    
    dict(str, double) data
        // possibly sometimes str, double[]

    //double[] = data         
    //double[][] data2d        //possibly  
    dict objects       //don't like the name


-------

Datcon Exper
    parent = "root" or none
    chidren Condits
    data :
        framecount
        wellcount
        folder
        conditDict
        condits
    objects = none

Datcon Condit
    
    