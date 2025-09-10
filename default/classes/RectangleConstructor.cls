public class RectangleConstructor {
Integer length,breadth;

    public RectangleConstructor (Integer l, Integer b){
        length=l;
        breadth=b;
    }    
    public void Area(){
        Integer a=length*breadth;
        System.debug('Area = '+a);
    }
    
    public void Perimeter(){
        Integer p= 2*(length+breadth);	
        System.debug('Perimeter = '+p);
    }
}