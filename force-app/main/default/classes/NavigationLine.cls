/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 10/12/2021
 */

public with sharing class NavigationLine {

    private Map<String, String> braceMap = new Map<String, String> {
            '(' => ')',
            '[' => ']',
            '{' => '}',
            '<' => '>'
    };

    private Map<String, Integer> validationPoints = new Map<String, Integer> {
            ')' => 3,
            ']' => 57,
            '}' => 1197,
            '>' => 25137
    };

    private Map<String, Integer> completionPoints = new Map<String, Integer> {
            ')' => 1,
            ']' => 2,
            '}' => 3,
            '>' => 4
    };


    private StringStack expectedClosingBraceStack = new StringStack();
    private String theLine;

    public NavigationLine(String theLine) {
        this.theLine = theLine;
    }

    public Integer validate() {
        for(Integer i=0; i < theLine.length(); i++) {

            String thisChar = theLine.substring(i, i+1);
            String closingBraceOrNull = braceMap.get(thisChar);

            if(closingBraceOrNull != null) {
                expectedClosingBraceStack.push(closingBraceOrNull);
            } else {
                String expectedClosingBrace = expectedClosingBraceStack.pop();
                if(thisChar != expectedClosingBrace) {
                    System.debug(String.format('Expected {0}, but found {1} instead', new List<String>{expectedClosingBrace, thisChar}));
                    return validationPoints.get(thisChar);
                }
            }
        }
        return 0;
    }

    public Long getCompletionScore() {
        Long result = 0;
        while(!expectedClosingBraceStack.isEmpty()) {
            result = (result * 5) + completionPoints.get(expectedClosingBraceStack.pop());
        }
        return result;
    }
}