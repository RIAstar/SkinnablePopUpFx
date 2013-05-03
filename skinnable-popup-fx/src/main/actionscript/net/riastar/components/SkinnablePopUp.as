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

import mx.core.FlexGlobals;
import mx.core.FlexVersion;
import mx.core.mx_internal;
import mx.events.FlexEvent;
import mx.managers.PopUpManager;
import mx.styles.StyleProtoChain;

import net.riastar.components.supportClasses.IPopUpPosition;

import spark.components.supportClasses.SkinnableComponent;
import spark.events.PopUpEvent;


use namespace mx_internal;


[Style(name="backgroundAlpha", type="Number", inherit="no", theme="spark, mobile")]
[Style(name="backgroundColor", type="uint", format="Color", inherit="no", theme="spark, mobile")]
[Style(name="borderAlpha", type="Number", inherit="no", theme="spark")]
[Style(name="borderColor", type="uint", format="Color", inherit="no", theme="spark")]
[Style(name="borderVisible", type="Boolean", inherit="no", theme="spark")]
[Style(name="color", type="uint", format="Color", inherit="yes", theme="spark")]
[Style(name="cornerRadius", type="Number", format="Length", inherit="no", theme="spark")]
[Style(name="dropShadowVisible", type="Boolean", inherit="no", theme="spark")]

[Event(name="open", type="spark.events.PopUpEvent")]
[Event(name="close", type="spark.events.PopUpEvent")]

[SkinState("open")]
[SkinState("closed")]
public class SkinnablePopUp extends SkinnableComponent {

    /* ------------------ */
    /* --- properties --- */
    /* ------------------ */

    public var modal:Boolean;

    private var _isOpen:Boolean;
    [Inspectable(category="General", defaultValue="false")]
    public function get isOpen():Boolean { return _isOpen; }
    private function setIsOpen(value:Boolean):void {
        _isOpen = value;

        if (skin) skin.addEventListener(FlexEvent.STATE_CHANGE_COMPLETE, handleSkinStateChange);
        else finalizeStateChange();

        invalidateSkinState();
    }

    private var _position:IPopUpPosition;
    public function get position():IPopUpPosition { return _position; }
    public function set position(value:IPopUpPosition):void {
        positionDirty = _position != value;
        _position = value;
        invalidateDisplayList();
    }

    private var closeEvent:PopUpEvent;
    private var addedToPopUpManager:Boolean;
    private var positionDirty:Boolean = true;


    /* -------------------- */
    /* --- construction --- */
    /* -------------------- */

    public function SkinnablePopUp(modal:Boolean = false) {
        this.modal = modal;
    }

    override mx_internal function initProtoChain():void {
        if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_6) super.initProtoChain();
        else StyleProtoChain.initProtoChain(this, false);
    }

    /* ---------------------- */
    /* --- event handlers --- */
    /* ---------------------- */

    private function handleSkinStateChange(event:FlexEvent):void {
        event.target.removeEventListener(FlexEvent.STATE_CHANGE_COMPLETE, handleSkinStateChange);
        finalizeStateChange();
    }


    /* ----------------- */
    /* --- behaviour --- */
    /* ----------------- */

    public function open(owner:DisplayObjectContainer = null):void {
        if (_isOpen) return;

        closeEvent = null;
        addPopUp(owner || FlexGlobals.topLevelApplication as DisplayObjectContainer);
        setIsOpen(true);
    }

    protected function addPopUp(owner:DisplayObjectContainer):void {
        this.owner = owner;

        if (!addedToPopUpManager) {
            addedToPopUpManager = true;
            PopUpManager.addPopUp(this, owner, modal);

            positionDirty = true;
            invalidateDisplayList();
        }
    }

    protected function notifyOpened():void {
        dispatchEvent(new PopUpEvent(PopUpEvent.OPEN));
    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
        super.updateDisplayList(unscaledWidth, unscaledHeight);

        if (addedToPopUpManager && _position && positionDirty) {
            _position.update(this);
            positionDirty = false;
        }
    }

    public function close(commit:Boolean = false, data:* = undefined):void {
        if (!_isOpen) return;

        closeEvent = new PopUpEvent(PopUpEvent.CLOSE, false, false, commit, data);
        setIsOpen(false);
    }

    protected function removePopUp():void {
        PopUpManager.removePopUp(this);
        initialized = false;
        addedToPopUpManager = false;
        owner = null;
    }

    protected function notifyClosed():void {
        dispatchEvent(closeEvent);
        closeEvent = null;
    }

    override protected function getCurrentSkinState():String {
        return _isOpen ? "open" : "closed";
    }

    protected function finalizeStateChange():void {
        if (_isOpen) notifyOpened();
        else {
            notifyClosed();
            removePopUp();
        }
    }

}
}
