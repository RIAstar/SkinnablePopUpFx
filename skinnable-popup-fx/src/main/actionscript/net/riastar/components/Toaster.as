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

import flash.events.TimerEvent;
import flash.utils.Dictionary;
import flash.utils.Timer;

import mx.collections.ArrayList;
import mx.collections.IList;
import mx.core.IDataRenderer;
import mx.core.IFactory;
import mx.core.IVisualElement;
import mx.effects.Effect;
import mx.events.EffectEvent;
import mx.events.ResizeEvent;

import net.riastar.components.supportClasses.PopUpAbsolutePosition;

import spark.components.DataGroup;
import spark.components.supportClasses.ListBase;
import spark.events.IndexChangeEvent;
import spark.events.RendererExistenceEvent;
import spark.events.SkinPartEvent;


public class Toaster extends SkinnablePopUp {

    /* ----------------- */
    /* --- skinparts --- */
    /* ----------------- */

    [SkinPart(required="true")]
    public var messageList:ListBase;

    [SkinPart(required="false")]
    public var rendererCreationEffect:Effect;

    [SkinPart(required="false")]
    public var rendererDestructionEffect:Effect;


    /* ------------------ */
    /* --- properties --- */
    /* ------------------ */

    public var showTime:int = 5000;

    private var _labelField:String = "label";
    public function get labelField():String { return _labelField; }
    public function set labelField(value:String):void {
        _labelField = value;
        if (messageList) messageList.labelField = value;
    }

    private var _labelFunction:Function;
    public function get labelFunction():Function { return _labelFunction; }
    public function set labelFunction(value:Function):void {
        _labelFunction = value;
        if (messageList) messageList.labelFunction = value;
    }

    private var _itemRenderer:IFactory;
    public function get itemRenderer():IFactory { return _itemRenderer; }
    public function set itemRenderer(value:IFactory):void {
        _itemRenderer = value;
        if (messageList) messageList.itemRenderer = value;
    }

    private var messages:IList = new ArrayList();
    private var timerMap:Dictionary = new Dictionary();


    /* -------------------- */
    /* --- construction --- */
    /* -------------------- */

    override public function initialize():void {
        position = new PopUpAbsolutePosition();
        super.initialize();
    }

    override protected function partAdded(partName:String, instance:Object):void {
        super.partAdded(partName, instance);

        switch (instance) {
            case messageList:
                initMessageList();
                break;
            case rendererDestructionEffect:
                rendererDestructionEffect.addEventListener(EffectEvent.EFFECT_END, handleDestructionEffectEnd);
                break;
        }
    }

    private function initMessageList():void {
        messageList.labelField = _labelField;
        messageList.labelFunction = _labelFunction;
        messageList.dataProvider = messages;

        if (_itemRenderer) messageList.itemRenderer = _itemRenderer;
        else _itemRenderer = messageList.itemRenderer;

        messageList.addEventListener(IndexChangeEvent.CHANGE, handleMessageSelection);
        messageList.addEventListener(ResizeEvent.RESIZE, handleListResize);
        messageList.addEventListener(SkinPartEvent.PART_ADDED, initRendererListeners);
    }

    private function initRendererListeners(event:SkinPartEvent):void {
        if (!(event.instance is DataGroup)) return;

        messageList.removeEventListener(SkinPartEvent.PART_ADDED, initRendererListeners);
        messageList.dataGroup.addEventListener(RendererExistenceEvent.RENDERER_ADD, handleItemRendererAdded);
    }


    /* ---------------------- */
    /* --- event handlers --- */
    /* ---------------------- */

    private function handleMessageSelection(event:IndexChangeEvent):void {
        //TODO handle toast selection
    }

    private function handleTimerComplete(event:TimerEvent):void {
        var timer:Timer = event.currentTarget as Timer;
        removeToast(timerMap[timer], true);
        destroyTimer(timer);
    }

    private function handleListResize(event:ResizeEvent):void {
        position.update(this);
    }

    private function handleItemRendererAdded(event:RendererExistenceEvent):void {
        playCreationEffect(event.renderer);
    }

    private function handleDestructionEffectEnd(event:EffectEvent):void {
        var itemRenderer:IDataRenderer = event.effectInstance.target as IDataRenderer;
        removeToast(itemRenderer.data, false);
    }


    /* ----------------- */
    /* --- behaviour --- */
    /* ----------------- */

    public function toast(item:Object):void {
        messages.addItem(item);
        createTimer(item);
        invalidateState();
    }

    protected function removeToast(item:Object, playEffect:Boolean):void {
        var index:int = messages.getItemIndex(item);
        if (index == -1) return;

        var itemRenderer:IVisualElement = messageList.dataGroup.getElementAt(index);
        if (!playEffect || !playDestructionEffect(itemRenderer)) {
            messages.removeItemAt(index);
            invalidateState();
        }
    }

    protected function playCreationEffect(itemRenderer:IVisualElement):Boolean {
        if (rendererCreationEffect) rendererCreationEffect.play([itemRenderer]);
        return rendererCreationEffect != null;
    }

    protected function playDestructionEffect(itemRenderer:IVisualElement):Boolean {
        if (rendererDestructionEffect) rendererDestructionEffect.play([itemRenderer]);
        return rendererDestructionEffect != null;
    }

    protected function createTimer(item:Object):void {
        var timer:Timer = new Timer(showTime, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete);
        timerMap[timer] = item;
        timer.start();
    }

    protected function destroyTimer(timer:Timer):void {
        timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete);
        delete timerMap[timer];
        timer = null;
    }

    protected function invalidateState():void {
        messages.length ? open() : close();
    }


    /* ------------------- */
    /* --- destruction --- */
    /* ------------------- */

    override protected function partRemoved(partName:String, instance:Object):void {
        switch (instance) {
            case messageList:
                messageList.dataGroup.removeEventListener(RendererExistenceEvent.RENDERER_ADD, handleItemRendererAdded);
                messageList.removeEventListener(IndexChangeEvent.CHANGE, handleMessageSelection);
                messageList.removeEventListener(ResizeEvent.RESIZE, handleListResize);
                break;
            case rendererDestructionEffect:
                rendererDestructionEffect.removeEventListener(EffectEvent.EFFECT_END, handleDestructionEffectEnd);
                break;
        }

        super.partRemoved(partName, instance);
    }

}
}
