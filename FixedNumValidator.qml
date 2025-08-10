// CustomTextField.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: root

    // Validation properties
    property int validationType: 0
    property int minLength: 0
    property int maxLength: 100
    property real minValue: 0
    property real maxValue: 999999
    property int decimalPlaces: 0
    property bool allowAlphabetic: true
    property bool allowNumeric: true
    property bool allowSpecialChars: false
    property string customRegex: ""
    property string validationMessage: ""

    // Password properties
    property bool isPassword: false
    property string confirmPassword: ""
    property bool isPasswordConfirmation: false

    // Visual feedback properties
    property color validColor: "#4CAF50"
    property color invalidColor: "#F44336"
    property color normalBorderColor: "#CCCCCC"

    // Internal properties
    property bool isValid: true
    property string errorMessage: ""

    // Styling
    selectByMouse: true
    echoMode: isPassword || isPasswordConfirmation ? TextInput.Password : TextInput.Normal

    background: Rectangle {
        color: "white"
        border.color: root.activeFocus ? (root.isValid ? root.validColor : root.invalidColor) : root.normalBorderColor
        border.width: root.activeFocus ? 2 : 1
        radius: 4

        Behavior on border.color {
            ColorAnimation { duration: 150 }
        }
    }

    // Set maximum length directly for string/alphanumeric/password fields
    maximumLength: (validationType === 0 || validationType === 2 || validationType === 3) ? maxLength : 32767

    // Input filter to prevent invalid input
    inputMethodHints: {
        if (validationType === 1) {
            if (decimalPlaces > 0) {
                return Qt.ImhFormattedNumbersOnly
            } else {
                return Qt.ImhDigitsOnly
            }
        }
        return Qt.ImhNone
    }

    // ENHANCED: Key press filtering ONLY for numeric inputs (validationType === 1)
    Keys.onPressed: {
        if (validationType === 1) { // Only for numeric validation
            if (!isValidNumericKeyPress(event)) {
                event.accepted = true // Block the key press
                return
            }
        }
        // All other validation types (0, 2, 3) work as before - no keystroke blocking
    }

    // Function to validate numeric key presses - ONLY for validationType === 1
    function isValidNumericKeyPress(event) {
        var key = event.key
        var inputChar = event.text

        // Allow navigation and control keys (always allowed for usability)
        if (key === Qt.Key_Left || key === Qt.Key_Right ||
            key === Qt.Key_Up || key === Qt.Key_Down ||
            key === Qt.Key_Home || key === Qt.Key_End ||
            key === Qt.Key_Tab || key === Qt.Key_Backtab ||
            key === Qt.Key_Delete || key === Qt.Key_Backspace) {
            return true
        }

        // Allow copy/paste shortcuts (always allowed)
        if ((event.modifiers & Qt.ControlModifier) &&
            (key === Qt.Key_C || key === Qt.Key_V || key === Qt.Key_X || key === Qt.Key_A)) {
            return true
        }

        // For numeric input, validate the character
        if (inputChar) {
            // Allow digits (0-9)
            if (/^\d$/.test(inputChar)) {
                return isValidNumericDigit(inputChar)
            }

            // Allow decimal point for float/double
            if (inputChar === "." && decimalPlaces > 0) {
                return isValidDecimalPoint()
            }

            // Allow minus sign for negative numbers
            if (inputChar === "-" && minValue < 0) {
                return isValidMinusSign()
            }

            // Block all other characters
            return false
        }

        return true
    }

    // Check if digit input is valid
    function isValidNumericDigit(digit) {
        var newText = getNewTextAfterInput(digit)

        // Check if resulting number would exceed maxValue
        var numValue = parseFloat(newText)
        if (!isNaN(numValue)) {
            if (numValue > maxValue) {
                return false
            }
        }

        // Check decimal places
        if (decimalPlaces > 0) {
            var decimalIndex = newText.indexOf('.')
            if (decimalIndex !== -1) {
                var decimals = newText.substring(decimalIndex + 1)
                if (decimals.length > decimalPlaces) {
                    return false // Block if it would exceed decimal places
                }
            }
        }

        return true
    }

    // Check if decimal point is valid
    function isValidDecimalPoint() {
        // Don't allow decimal point for integer fields
        if (decimalPlaces === 0) {
            return false
        }

        // Only allow one decimal point
        if (text.indexOf('.') !== -1) {
            return false
        }

        return true
    }

    // Check if minus sign is valid
    function isValidMinusSign() {
        // Only allow at the beginning of the field
        if (cursorPosition !== 0) {
            return false
        }

        // Don't allow if already has minus sign
        if (text.indexOf('-') !== -1) {
            return false
        }

        // Don't allow if minValue >= 0
        if (minValue >= 0) {
            return false
        }

        return true
    }

    // Helper function to simulate text after input
    function getNewTextAfterInput(inputChar) {
        return text.slice(0, cursorPosition) + inputChar + text.slice(cursorPosition)
    }

    onTextEdited: {
        if (validationType === 1) {
            var newText = text
            var numValue = parseFloat(newText)

            // Check if the value exceeds maximum
            if (!isNaN(numValue) && numValue > maxValue) {
                // Revert to previous valid value
                text = previousValidText
                return
            }

            // Check decimal places
            if (decimalPlaces === 0 && newText.indexOf('.') !== -1) {
                text = previousValidText
                return
            }

            if (decimalPlaces > 0 && newText.indexOf('.') !== -1) {
                var decimalIndex = newText.indexOf('.')
                var decimals = newText.substring(decimalIndex + 1)
                if (decimals.length > decimalPlaces) {
                    text = previousValidText
                    return
                }
            }

            // Store valid text for next comparison
            previousValidText = newText
        }
    }

    // Store previous valid text for numeric fields
    property string previousValidText: ""

    // Validation function
    function validateInput(inputText) {
        if (!inputText) inputText = text

        var valid = true
        var message = ""

        switch(validationType) {
            case 0: // Alphanumeric validation
                valid = validateAlphanumeric(inputText)
                break
            case 1: // Numeric validation
                valid = validateNumeric(inputText)
                break
            case 2: // Custom regex validation
                valid = validateCustom(inputText)
                break
            case 3: // Password validation
                valid = validatePassword(inputText)
                break
        }

        isValid = valid
        errorMessage = message
        return valid
    }

    function validateAlphanumeric(inputText) {
        // Check length
        if (inputText.length < minLength) {
            errorMessage = "Minimum " + minLength + " characters required"
            return false
        }
        if (inputText.length > maxLength) {
            errorMessage = "Maximum " + maxLength + " characters allowed"
            return false
        }

        // Check character types
        var regex = ""
        if (allowAlphabetic && allowNumeric) {
            regex = "^[a-zA-Z0-9"
        } else if (allowAlphabetic) {
            regex = "^[a-zA-Z"
        } else if (allowNumeric) {
            regex = "^[0-9"
        }

        if (allowSpecialChars) {
            regex += "\\s\\-_"  // Allow space, hyphen, underscore
        }

        regex += "]+$"

        var regExp = new RegExp(regex)
        if (!regExp.test(inputText)) {
            var allowedTypes = []
            if (allowAlphabetic) allowedTypes.push("letters")
            if (allowNumeric) allowedTypes.push("numbers")
            if (allowSpecialChars) allowedTypes.push("spaces, hyphens, underscores")

            errorMessage = "Only " + allowedTypes.join(", ") + " allowed"
            return false
        }

        errorMessage = ""
        return true
    }

    function validateNumeric(inputText) {
        // Allow empty string during typing
        if (inputText === "" || inputText === "-" || inputText === ".") {
            if (minLength > 0 && !activeFocus) {
                errorMessage = "This field is required"
                return false
            }
            errorMessage = ""
            return true
        }

        // Check if it's a valid number
        var numValue = parseFloat(inputText)
        if (isNaN(numValue)) {
            errorMessage = "Please enter a valid number"
            return false
        }

        // Check range
        if (numValue < minValue) {
            errorMessage = "Minimum value is " + minValue
            return false
        }
        if (numValue > maxValue) {
            errorMessage = "Maximum value is " + maxValue
            return false
        }

        // Check decimal places
        if (decimalPlaces === 0 && inputText.indexOf('.') !== -1) {
            errorMessage = "Decimal numbers not allowed"
            return false
        }

        if (decimalPlaces > 0) {
            var decimalIndex = inputText.indexOf('.')
            if (decimalIndex !== -1) {
                var decimals = inputText.substring(decimalIndex + 1)
                if (decimals.length > decimalPlaces) {
                    errorMessage = "Maximum " + decimalPlaces + " decimal places allowed"
                    return false
                }
            }
        }

        errorMessage = ""
        return true
    }

    function validateCustom(inputText) {
        if (customRegex === "") return true

        var regExp = new RegExp(customRegex)
        var valid = regExp.test(inputText)

        if (!valid) {
            errorMessage = validationMessage || "Invalid input format"
        } else {
            errorMessage = ""
        }

        return valid
    }

    function validatePassword(inputText) {
        // Check length
        if (inputText.length < minLength) {
            errorMessage = "Password must be at least " + minLength + " characters"
            return false
        }
        if (inputText.length > maxLength) {
            errorMessage = "Password cannot exceed " + maxLength + " characters"
            return false
        }

        // For password confirmation field
        if (isPasswordConfirmation) {
            if (inputText !== confirmPassword) {
                errorMessage = "Passwords do not match"
                return false
            }
        }

        // Basic password strength requirements (you can customize these)
        if (minLength > 0) {
            var hasUpper = /[A-Z]/.test(inputText)
            var hasLower = /[a-z]/.test(inputText)
            var hasNumber = /\d/.test(inputText)
            var hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(inputText)

            if (!hasUpper || !hasLower || !hasNumber || !hasSpecial) {
                errorMessage = "Password must contain uppercase, lowercase, number, and special character"
                return false
            }
        }

        errorMessage = ""
        return true
    }

    // Input filtering for numeric fields - kept for additional validation
    validator: {
        if (validationType === 1) {
            if (decimalPlaces > 0) {
                return doubleValidator
            } else {
                return intValidator
            }
        }
        return null
    }

    IntValidator {
        id: intValidator
        bottom: minValue
        top: maxValue
    }

    DoubleValidator {
        id: doubleValidator
        bottom: minValue
        top: maxValue
        decimals: decimalPlaces
    }

    // Initialize previous valid text
    Component.onCompleted: {
        if (validationType === 1) {
            previousValidText = text
        }
    }

    // Real-time Validation
    onTextChanged: {
        if (validationType === 1) {
            if (!activeFocus) {
                validateInput()
            } else {
                // During typing, only show critical range errors
                if (text !== "") {
                    var numValue = parseFloat(text)
                    if (!isNaN(numValue) && (numValue < minValue || numValue > maxValue)) {
                        isValid = false
                        if (numValue < minValue) {
                            errorMessage = "Minimum value is " + minValue
                        } else {
                            errorMessage = "Maximum value is " + maxValue
                        }
                    } else {
                        isValid = true
                        errorMessage = ""
                    }
                }
            }
        } else {
            validateInput()
        }
    }

    // Full validation on focus loss
    onActiveFocusChanged: {
        if (!activeFocus) {
            validateInput()
        }
    }

    // Public method to check validation
    function isInputValid() {
        return validateInput()
    }

    // Method to get validation error
    function getValidationError() {
        return errorMessage
    }

    // Method to clear validation
    function clearValidation() {
        isValid = true
        errorMessage = ""
    }
}
