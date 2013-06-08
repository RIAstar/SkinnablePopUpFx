/*
 * Copyright (c) 2013 Maxime Cowez a.k.a. RIAstar.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 * OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * @author RIAstar
 */
package net.riastar.components {

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import mx.styles.CSSStyleDeclaration;
import mx.styles.IStyleClient;
import mx.styles.StyleProtoChain;

import spark.events.PopUpEvent;


//SkinnablePopUp styles
[Style(name="backgroundAlpha", type="Number", inherit="no", theme="spark, mobile")]
[Style(name="backgroundColor", type="uint", format="Color", inherit="no", theme="spark, mobile")]
[Style(name="borderAlpha", type="Number", inherit="no", theme="spark")]
[Style(name="borderColor", type="uint", format="Color", inherit="no", theme="spark")]
[Style(name="borderVisible", type="Boolean", inherit="no", theme="spark")]
[Style(name="color", type="uint", format="Color", inherit="yes", theme="spark")]
[Style(name="cornerRadius", type="Number", format="Length", inherit="no", theme="spark")]
[Style(name="dropShadowVisible", type="Boolean", inherit="no", theme="spark")]

//inherited styles
[Style(name="skinClass", type="Class")]

[Event(name="open", type="spark.events.PopUpEvent")]
[Event(name="close", type="spark.events.PopUpEvent")]

public class AlertDelegate extends EventDispatcher implements IStyleClient {

    private var _text:String;
    public function get text():String { return _text; }
    public function set text(value:String):void {
        _text = value;
        if (instance) instance.text = value;
    }

    private var _title:String;
    public function get title():String { return _title; }
    public function set title(value:String):void {
        _title = value;
        if (instance) instance.title = value;
    }

    private var _modal:Boolean;
    public function get modal():Boolean { return _modal; }
    public function set modal(value:Boolean):void {
        _modal = value;
        if (instance) instance.modal = value;
    }

    private var _committable:Boolean;
    public function get committable():Boolean { return _committable; }
    public function set committable(value:Boolean):void {
        _committable = value;
        if (instance) instance.committable = value;
    }

    private var _cancelable:Boolean;
    public function get cancelable():Boolean { return _cancelable; }
    public function set cancelable(value:Boolean):void {
        _cancelable = value;
        if (instance) instance.cancelable = value;
    }

    private var _discardable:Boolean;
    public function get discardable():Boolean { return _discardable; }
    public function set discardable(value:Boolean):void {
        _discardable = value;
        if (instance) instance.discardable = value;
    }

    private var _commitLabel:String;
    public function get commitLabel():String { return _commitLabel; }
    public function set commitLabel(value:String):void {
        _commitLabel = value;
        if (instance) instance.commitLabel = value;
    }

    private var _cancelLabel:String;
    public function get cancelLabel():String { return _cancelLabel; }
    public function set cancelLabel(value:String):void {
        _cancelLabel = value;
        if (instance) instance.cancelLabel = value;
    }

    private var _discardLabel:String;
    public function get discardLabel():String { return _discardLabel; }
    public function set discardLabel(value:String):void {
        _discardLabel = value;
        if (instance) instance.discardLabel = value;
    }

    private var _maxWidth:Number;
    public function get maxWidth():Number { return _maxWidth; }
    public function set maxWidth(value:Number):void {
        _maxWidth = value;
        if (instance) instance.maxWidth = value;
    }

    private var instance:Alert;

    public function open(owner:DisplayObjectContainer = null):void {
        instance = new Alert(text, title, modal);
        instance.committable = _committable;
        instance.cancelable = _cancelable;
        instance.discardable = _discardable;
        instance.commitLabel = _commitLabel;
        instance.discardLabel = _discardLabel;
        instance.cancelLabel = _cancelLabel;
        instance.maxWidth = _maxWidth;

        instance.styleName = _styleName;
        instance.inheritingStyles = _inheritingStyles;
        instance.nonInheritingStyles = _nonInheritingStyles;
        instance.styleDeclaration = _styleDeclaration;

        for (var styleProp:String in deferredStyles)
            instance.setStyle(styleProp, deferredStyles[styleProp]);

        instance.addEventListener(PopUpEvent.OPEN, dispatchEvent);
        instance.addEventListener(PopUpEvent.CLOSE, handlePopUpClose);
        instance.open(owner);
    }

    public function close(commit:Boolean = false, data:* = undefined):void {
        instance.close(commit, data);
        instance = null;
    }

    private function handlePopUpClose(event:PopUpEvent):void {
        dispatchEvent(event);
        instance.removeEventListener(PopUpEvent.OPEN, dispatchEvent);
        instance.removeEventListener(PopUpEvent.CLOSE, handlePopUpClose);
        instance = null;
    }

    override public function dispatchEvent(event:Event):Boolean {
        return super.dispatchEvent(event.clone());
    }


    /* -------------------- */
    /* --- IStyleClient --- */
    /* -------------------- */

    private var _styleName:Object;
    public function get styleName():Object { return _styleName; }
    public function set styleName(value:Object):void {
        _styleName = value;
        if (instance) instance.styleName = value;
    }

    public function styleChanged(styleProp:String):void {
        if (instance) instance.styleChanged(styleProp);
    }

    public function get className():String {
        return instance ? instance.className : null;
    }

    private var _inheritingStyles:Object = StyleProtoChain.STYLE_UNINITIALIZED;
    public function get inheritingStyles():Object { return _inheritingStyles; }
    public function set inheritingStyles(value:Object):void {
        _inheritingStyles = value;
        if (instance) instance.inheritingStyles = value;
    }

    private var _nonInheritingStyles:Object = StyleProtoChain.STYLE_UNINITIALIZED;
    public function get nonInheritingStyles():Object { return _nonInheritingStyles; }
    public function set nonInheritingStyles(value:Object):void {
        _nonInheritingStyles = value;
        if (instance) instance.nonInheritingStyles = value;
    }

    private var _styleDeclaration:CSSStyleDeclaration;
    public function get styleDeclaration():CSSStyleDeclaration { return _styleDeclaration; }
    public function set styleDeclaration(value:CSSStyleDeclaration):void {
        _styleDeclaration = value;
        if (instance) instance.styleDeclaration = value;
    }

    private var deferredStyles:Dictionary = new Dictionary();
    public function getStyle(styleProp:String):* {
        return instance ? instance.getStyle(styleProp) : deferredStyles[styleProp];
    }
    public function setStyle(styleProp:String, newValue:*):void {
        if (instance) instance.setStyle(styleProp, newValue);
        else deferredStyles[styleProp] = newValue;
    }

    public function clearStyle(styleProp:String):void {
        if (instance) instance.clearStyle(styleProp);
    }

    public function getClassStyleDeclarations():Array {
        return instance ? instance.getClassStyleDeclarations() : null;
    }

    public function notifyStyleChangeInChildren(styleProp:String, recursive:Boolean):void {
        if (instance) instance.notifyStyleChangeInChildren(styleProp, recursive);
    }

    public function regenerateStyleCache(recursive:Boolean):void {
        if (instance) instance.regenerateStyleCache(recursive);
    }

    public function registerEffects(effects:Array):void {
        if (instance) instance.registerEffects(effects);
    }

}
}
