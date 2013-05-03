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
package net.riastar.demo.view {

import net.riastar.skins.spark.AlertSkin;

import spark.components.supportClasses.SkinnableComponent;


public class PropertyPanel extends SkinnableComponent {

    //properties

    [Bindable]
    public var modal:Boolean = true;

    [Bindable]
    public var title:String = "An Alert title";

    [Bindable]
    public var text:String = "Here's where we ask the user a silly question.";

    [Bindable]
    public var committable:Boolean = true;

    [Bindable]
    public var discardable:Boolean;

    [Bindable]
    public var cancelable:Boolean;

    private var _commitLabel:String;
    [Bindable]
    public function get commitLabel():String { return _commitLabel; }
    public function set commitLabel(value:String):void {
        _commitLabel = value == "" ? null : value;
    }

    private var _discardLabel:String;
    [Bindable]
    public function get discardLabel():String { return _discardLabel; }
    public function set discardLabel(value:String):void {
        _discardLabel = value == "" ? null : value;
    }

    private var _cancelLabel:String;
    [Bindable]
    public function get cancelLabel():String { return _cancelLabel; }
    public function set cancelLabel(value:String):void {
        _cancelLabel = value == "" ? null : value;
    }

    [Bindable]
    public var maxPopUpWidth:Number = 250;


    //styles

    [Bindable]
    public var _skinClass:* = AlertSkin;

    [Bindable]
    public var backgroundAlpha:Number = 1;

    [Bindable]
    public var backgroundColor:uint = 0xffffff;

    [Bindable]
    public var borderAlpha:Number = .5;

    [Bindable]
    public var borderColor:uint = 0x000000;

    [Bindable]
    public var borderVisible:Boolean = true;

    [Bindable]
    public var cornerRadius:Number = 0;

    [Bindable]
    public var color:uint = 0x000000;

    [Bindable]
    public var dropShadowVisible:Boolean = true;

}
}
