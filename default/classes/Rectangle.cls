public class Rectangle {
Integer length,breadth;

    public void Area(){
        Integer a=length*breadth;
        System.debug('Area = '+a);
    }
    
    public void Perimeter(){
        Integer p= 2*(length+breadth);	
        System.debug('Perimeter = '+p);
    }
}