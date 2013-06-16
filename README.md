##SkinnablePopUpFx: A Flex/Spark skinnable popup component

SkinnablePopUpFx is not just one component it consists of:

 - SkinnablePopUp: a base class that can be extended to create custom popups
 - Alert: a default implementation
 - Toaster: toast-style messages

###Example Alert

    <fx:Declarations>
        <rs:Alert id="alert" title="Hello world"
                  text="Are you sure you wish to say hello?"/>
    </fx:Declarations>

    <s:Button label="Say hello" click="alert.open()"/>

###Example Toaster

    <fx:Declarations>
        <rs:Toaster id="toaster" width="150" bottom="20" right="20"/>
    </fx:Declarations>

    <s:Button label="Say hello" click="toaster.toast('Hello there from the Toaster')"/>

##SkinnablePopUp
SkinnablePopUp extends SkinnableComponent and adds popup behaviour to it. The following attributes have been added:

###Additional properties:
 - modal
 - isOpen (read-only)
 - position

###Additional methods:
 - open()
 - close()

###SkinStates:
 - open
 - closed

###Additional Events:
 - PopUpEvent.OPEN
 - PopUpEvent.CLOSE

###Additional styles:
 - backgroundAlpha / backgroundColor
 - borderAlpha / borderColor / borderVisible
 - cornerRadius
 - dropShadowVisible

##Alert
Alert extends SkinnablePopUp and provides functionality similar to that of the old mx Alert class, but built on the Spark skinning architecture.

###Additional SkinParts:
 - titleDisplay / textDisplay
 - commitButton / discardButton / cancelButton

###Additional properties:
 - title / text
 - committable / discardable / cancelable
 - commitLabel / discardLabel / cancelLabel

##Toaster
Toaster is another implementation of SkinnablePopUp that provides a means of displaying toast-like messages.

###Additional SkinParts
 - messageList
 - rendererCreationEffect (optional)
 - rendererDestructionEffect (optional)

###Additional properties
 - showTime 
 - labelField 
 - labelFunction
 - itemRenderer

###Additional methods
 - toast(*message*)

