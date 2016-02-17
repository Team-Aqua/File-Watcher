module FileWatcher
    module Exceptions
        # Occurs when user enters a null matrix for processing.
        class NullMatrixException < StandardError; end 

        # Occurs when a sparse matrix operation occurs wherein its dimensions result in the operation being unavailable.   
        class MatrixDimException < StandardError; end      

        # Occurs when the matrix builder expects a specific type; and is provided the wrong type to generate the sparse matrix.
        class MatrixTypeException < StandardError; end 

        # Occurs when the system divides by 0; standard arithmetic error.    
        class DivideByZeroException < StandardError; end   

        # Occurs when index queried is out of range of the matrix.
        class IndexOutOfRangeException < StandardError; end
        
        # Occurs when the sparse matrix is used in processing against a null / nil value.
        class ArgumentNullException < StandardError; end   

        # Occurs anytime an invariant is violated.
        class InvariantError < StandardError; end 

        # Occurs when the return values is incorrect or post conditions are not met.
        class ContractReturnError < StandardError; end

        #
        class InputOverflowError < StandardError; end

        #
        class MatrixValueOverflowError < StandardError; end

        # Occurs when a bad input (generally within specific bounds) is entered.
        class BadInputException < StandardError; end

    end # exceptions
end