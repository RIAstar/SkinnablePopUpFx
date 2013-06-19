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

import flash.events.MouseEvent;

import mx.core.IVisualElement;

import net.riastar.components.supportClasses.PopUpCenteredPosition;
import net.riastar.events.AlertResponse;

import spark.components.supportClasses.ButtonBase;
import spark.core.IDisplayText;
import spark.primitives.BitmapImage;


[Style(name="icon", type="Object", inherit="no")]
[Style(name="iconPlacement", type="String", enumeration="right,left", inherit="no", theme="spark, mobile")]
[Style(name="iconAlign", type="String", enumeration="top,middle,bottom", inherit="no", theme="spark, mobile")]

public class Alert extends SkinnablePopUp {

    /* ----------------- */
    /* --- skinparts --- */
    /* ----------------- */

    [SkinPart(required="true")]
    public var textDisplay:IDisplayText;

    [SkinPart(required="false")]
    public var titleDisplay:IDisplayText;

    [SkinPart(required="false")]
    public var commitButton:IVisualElement;

    [SkinPart(required="false")]
    public var discardButton:IVisualElement;

    [SkinPart(required="false")]
    public var cancelButton:IVisualElement;

    [SkinPart(required="false")]
    public var iconDisplay:BitmapImage;


    /* ------------------ */
    /* --- properties --- */
    /* ------------------ */

    private var _text:String;
    public function get text():String { return _text; }
    public function set text(value:String):void {
        _text = value;
        invalidateProperties();
    }

    private var _title:String;
    public function get title():String { return _title; }
    public function set title(value:String):void {
        _title = value;
        invalidateProperties();
    }

    private var _committable:Boolean = true;
    public function get committable():Boolean { return _committable; }
    public function set committable(value:Boolean):void {
        _committable = value;
        invalidateProperties();
    }

    private var _discardable:Boolean;
    public function get discardable():Boolean { return _discardable; }
    public function set discardable(value:Boolean):void {
        _discardable = value;
        invalidateProperties();
    }

    private var _cancelable:Boolean;
    public function get cancelable():Boolean { return _cancelable; }
    public function set cancelable(value:Boolean):void {
        _cancelable = value;
        invalidateProperties();
    }

    private var _commitLabel:String;
    public function get commitLabel():String { return _commitLabel; }
    public function set commitLabel(value:String):void {
        _commitLabel = value;
        invalidateProperties();
    }

    private var _discardLabel:String;
    public function get discardLabel():String { return _discardLabel; }
    public function set discardLabel(value:String):void {
        _discardLabel = value;
        invalidateProperties();
    }

    private var _cancelLabel:String;
    public function get cancelLabel():String { return _cancelLabel; }
    public function set cancelLabel(value:String):void {
        _cancelLabel = value;
        invalidateProperties();
    }


    /* -------------------- */
    /* --- construction --- */
    /* -------------------- */

    public function Alert(text:String = null, title:String = null, modal:Boolean = true) {
        super(modal);

        _text = text;
        _title = title;
    }

    override public function initialize():void {
        position = new PopUpCenteredPosition();
        super.initialize();
    }

    override protected function partAdded(partName:String, instance:Object):void {
        super.partAdded(partName, instance);

        switch (instance) {
            case commitButton:
                commitButton.addEventListener(MouseEvent.CLICK, handleCommitButtonClick);
                break;
            case discardButton:
                discardButton.addEventListener(MouseEvent.CLICK, handleDiscardButtonClick);
                break;
            case cancelButton:
                cancelButton.addEventListener(MouseEvent.CLICK, handleCancelButtonClick);
                break;
            case iconDisplay:
                iconDisplay.includeInLayout = iconDisplay.source = getStyle("icon");
                break;
        }

        invalidateProperties();
    }


    /* ---------------------- */
    /* --- event handlers --- */
    /* ---------------------- */

    private function handleCommitButtonClick(event:MouseEvent):void {
        close(true, AlertResponse.COMMIT);
    }

    private function handleDiscardButtonClick(event:MouseEvent):void {
        close(false, AlertResponse.DISCARD);
    }

    private function handleCancelButtonClick(event:MouseEvent):void {
        close(false, AlertResponse.CANCEL);
    }


    /* ----------------- */
    /* --- behaviour --- */
    /* ----------------- */

    override protected function commitProperties():void {
        super.commitProperties();

        if (textDisplay) textDisplay.text = _text;
        if (titleDisplay) titleDisplay.text = _title;

        commitButtonProperties(commitButton, _committable, "commitLabel");
        commitButtonProperties(discardButton, _discardable, "discardLabel");
        commitButtonProperties(cancelButton, _cancelable, "cancelLabel");
    }

    protected function commitButtonProperties(button:IVisualElement, active:Boolean, label:String):void {
        if (!button) return;

        button.visible = button.includeInLayout = active;
        if (active && button is ButtonBase)
            ButtonBase(button).label = this[label] || resourceManager.getString('component', label);
    }

    override public function styleChanged(styleProp:String):void {
        if (iconDisplay && (!styleProp || styleProp == "styleName" || styleProp == "icon"))
            iconDisplay.includeInLayout = iconDisplay.source = getStyle("icon");

        super.styleChanged(styleProp);
    }


    /* ------------------- */
    /* --- destruction --- */
    /* ------------------- */

    override protected function partRemoved(partName:String, instance:Object):void {
        switch (instance) {
            case commitButton:
                commitButton.removeEventListener(MouseEvent.CLICK, handleCommitButtonClick);
                break;
            case discardButton:
                discardButton.removeEventListener(MouseEvent.CLICK, handleDiscardButtonClick);
                break;
            case cancelButton:
                cancelButton.removeEventListener(MouseEvent.CLICK, handleCancelButtonClick);
                break;
        }

        super.partRemoved(partName, instance);
    }

}
}
