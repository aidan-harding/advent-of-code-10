/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 10/12/2021
 * @description (if required)
 */

public with sharing class StringStack {
    private List<String> theStack = new List<String>();

    public void push(String s) {
        theStack.add(s);
    }

    public String pop() {
        return theStack.remove(theStack.size()-1);
    }

    public Boolean isEmpty() {
        return theStack.isEmpty();
    }
}