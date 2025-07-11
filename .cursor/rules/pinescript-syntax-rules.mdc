---
description: 
globs: 
alwaysApply: false
---
# Pine Script Syntax Rules

## Avoiding "End of Line Without Line Continuation" Errors

1. **KEEP STATEMENTS ON A SINGLE LINE**: The most reliable approach is to keep each statement on a single line, even if it makes lines long.

2. **NO BACKSLASHES**: Unlike many other languages, Pine Script doesn't use backslashes `\` for line continuation.

3. **FUNCTION CALLS**: When calling functions with multiple parameters, keep all parameters on the same line:
   ```pine
   line.new(bar_index, price1, bar_index+10, price2, color=color.blue, width=2)
   ```

4. **TERNARY OPERATORS**: Keep the entire ternary expression on a single line:
   ```pine
   bandColor = condition1 ? color.green : condition2 ? color.orange : color.red
   ```

5. **FUNCTION PARAMETERS**: When creating functions, put all parameters on the same line:
   ```pine
   myFunction(param1, param2, param3) => 
       // Function body here
   ```

6. **OBJECT CREATION**: When creating objects (like lines, labels, boxes), put all parameters on a single line:
   ```pine
   box.new(x1, y1, x2, y2, bgcolor=color.blue, border_color=color.black, border_width=1)
   ```

7. **ARITHMETIC EXPRESSIONS**: Keep complex arithmetic expressions on a single line rather than splitting them:
   ```pine
   result = (price1 * weight1 + price2 * weight2) / (weight1 + weight2)
   ```

8. **ARRAY OPERATIONS**: Keep array operations on a single line:
   ```pine
   array.push(myArray, newValue)
   ```

9. **CONDITIONAL STATEMENTS**: For conditional statements, keep the condition on one line, and use proper indentation for the code block:
   ```pine
   if condition
       statement1
       statement2
   ```

## Variable Declaration and Scope

1. **DECLARE VARIABLES BEFORE USE**: Always declare variables before using them, especially in functions.
   ```pine
   // Correct
   myVar = 0
   myVar := myVar + 1
   
   // Incorrect
   myVar := myVar + 1  // Error: undeclared identifier
   ```

2. **USE CORRECT ASSIGNMENT OPERATORS**: Use `=` for initial assignment and `:=` for reassignment.
   ```pine
   // Initial assignment
   myVar = 10
   
   // Reassignment
   myVar := 20
   ```

3. **RESPECT VARIABLE SCOPE**: Variables declared in functions can't modify global variables unless using the `export` keyword.
   ```pine
   var global = 0
   
   myFunction() =>
       local = 5  // Local variable
       // Cannot modify global from function without export
   ```

## Function Definition and Usage

1. **FUNCTION SYNTAX**: Use the `=>` operator for function declarations with proper indentation:
   ```pine
   myFunction(param1, param2) =>
       result = param1 + param2
       result
   ```

2. **CHECK FUNCTION PARAMETERS**: Verify the required parameters for built-in functions:
   ```pine
   // Correct
   input.session("0930-1600", "Session")
   
   // Incorrect
   input.time("0930", "Time")  // Wrong parameter type
   ```

3. **PROPER RETURN VALUES**: When a function returns multiple values, use array brackets for assignment:
   ```pine
   [value1, value2, value3] = myFunction()
   ```

4. **DEFAULT PARAMETER VALUES**: You can specify default values for function parameters:
   ```pine
   myFunction(param1, param2 = 10) =>
       param1 + param2
   ```

## Type System

1. **RESPECT TYPE CONSTRAINTS**: Always use the correct type when passing arguments to functions.
   ```pine
   // Correct
   ta.change(close)  // close is series float
   
   // Incorrect
   ta.change("string")  // Error: expected series float
   ```

2. **USE TYPE ANNOTATIONS**: When declaring arrays or complex variables, use type annotations:
   ```pine
   var array<float> myFloats = array.new_float(0)
   var array<string> myStrings = array.new_string(0)
   ```

3. **TYPE CONSISTENCY**: In conditional statements, ensure both branches return the same type:
   ```pine
   // Correct
   x = if close > open
       close
   else
       open
   
   // Incorrect (will not compile)
   y = if close > open
       close
   else
       "open"
   ```

## Conditional Statements

1. **IF STATEMENT SYNTAX**: Proper indentation is required for if statements:
   ```pine
   if condition
       statement1
       statement2
   else if anotherCondition
       statement3
       statement4
   else
       statement5
       statement6
   ```

2. **RETURNING VALUES FROM IF**: Use the assignment form to capture the result of if statements:
   ```pine
   result = if condition
       valueIfTrue
   else
       valueIfFalse
   ```

3. **NESTED IF STATEMENTS**: You can nest if statements with proper indentation:
   ```pine
   if condition1
       if condition2
           statement1
       else
           statement2
   else
       statement3
   ```

## Version Declaration

1. **ALWAYS SPECIFY VERSION**: Always include the version annotation at the top of your script:
   ```pine
   //@version=5
   indicator("My Indicator")
   ```

2. **CORRECT VERSION PLACEMENT**: Place the version annotation at the beginning of your script for readability.

## Session and Time Handling

1. **USE PROPER TIME FUNCTIONS**: For session time inputs, use `input.session` instead of `input.time`:
   ```pine
   // Correct
   sessionInput = input.session("0930-1600", "Trading Session")
   
   // Incorrect
   timeInput = input.time("0930", "Time")  // May expect different format
   ```

2. **SESSION CHECKING**: Use built-in session functions for checking session state:
   ```pine
   // Correct
   inSession = session.ismarket
   
   // Alternative method using time
   startTime = timestamp(year, month, day, 9, 30)
   endTime = timestamp(year, month, day, 16, 0)
   inSession = time >= startTime and time <= endTime
   ```

## Comments and Documentation

1. **USE APPROPRIATE COMMENTS**: Use `//` for single-line comments and `/* */` for multi-line comments:
   ```pine
   // This is a single-line comment
   
   /*
   This is a
   multi-line comment
   */
   ```

2. **DOCUMENT YOUR CODE**: Add comments to explain complex logic, especially when creating libraries or indicators others might use.

Following these rules will help you create Pine Script code that is both syntactically correct and easier to maintain. 