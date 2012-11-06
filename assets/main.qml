/*
 * Copyright (c) 2012 SSP Europe GmbH, Munich
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades 1.0
import bb.cascades.pickers 1.0

/*
 * 
 * Author: Ekkehard Gentz (ekke), Rosenheim, Germany
 * 
 */

Page {
    id: page
    attachedObjects: [
        // Cascades FilePicker
        FilePicker {
            id: picker
            property string selectedFile
            title: qsTr("File Picker")
            mode: FilePickerMode.Picker
            type: FileType.Other
            sortBy: FilePickerSortFlag.Default
            sortOrder: FilePickerSortOrder.Default
            onFileSelected: {
                selectedFile = selectedFiles[0]
                fileActions()
            }
        }
    ]
    actions: [
        ActionItem {
            id: cloudActionPreviewer
            title: qsTr("Preview") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/4-collections-cloud_newLabel81.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                app.invokeBoundODSPreviewer(picker.selectedFile)
                resetFields()
            }
        },
        ActionItem {
            id: cloudActionComposer
            title: qsTr("Compose") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/4-collections-cloud_newLabel81.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                app.invokeBoundODSComposer(picker.selectedFile)
                resetFields()
            }
        },
        InvokeActionItem {
            id: openAction
            ActionBar.placement: ActionBarPlacement.OnBar
            query {
                // little trick: always use same mime type, because query needs a mime type
                // ODS then takes a look at file path suffix to see if file is supported
                mimeType: "image/png"
                invokeActionId: "bb.action.OPEN"
                invokeTargetId: "io.ods.bb10.invoke"
            }
            onTriggered: {
                // we dont need the file - the app is only opened
            }
        },
        InvokeActionItem {
            id: shareAction
            ActionBar.placement: ActionBarPlacement.OnBar
            query {
                // little trick: always use same mime type, because query needs a mime type
                // ODS then takes a look at file path suffix to see if file is supported
                mimeType: "image/png"
                invokeActionId: "bb.action.SHARE"
                invokeTargetId: "io.ods.bb10.card.upload.previewer"
            }
            onTriggered: {
                // next trick: all properties from query are read-only
                // but we can use the data, which is read-write
                data = picker.selectedFile
                resetFields()
            }
        },
        ActionItem {
            title: qsTr("Select Document") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/4-collections-view-as-list81.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                picker.title = qsTr("Select Document")
                picker.type = FileType.Document
                picker.directories = [
                ]
                picker.open();
            }
        },
        ActionItem {
            title: qsTr("Select | Capture Image") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/5-content-picture81.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                picker.title = qsTr("Select Image")
                picker.type = FileType.Picture
                picker.directories = [
                ]
                picker.open();
            }
        },
        ActionItem {
            title: qsTr("Select | Capture Video") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/10-device-access-video81.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                picker.title = qsTr("Select Video")
                picker.type = FileType.Video
                picker.directories = [
                ]
                picker.open();
            }
        },
        ActionItem {
            title: qsTr("Select Music") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/9-av-play81.png"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                picker.title = qsTr("Select Music")
                picker.type = FileType.Music
                picker.directories = [
                ]
                picker.open();
            }
        }
    ]
    titleBar: TitleBar {
        id: titleBarId
        title: qsTr("Invoke ODS as APP vs Card") + Retranslate.onLanguageChanged
        visibility: ChromeVisibility.Visible
    }
    Container {
        layout: DockLayout {
        }
        ImageView {
            id: redImage
            visible: false
            imageSource: "asset:///images/cancel_red.png"
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Left
            translationX: 10
            translationY: 10
        }
        ImageView {
            id: greenImage
            visible: false
            imageSource: "asset:///images/checked_green.png"
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Left
            translationX: 10
            translationY: 10
        }
        TextArea {
            id: theNextStep
            editable: false
            text: ""
            textStyle.base: SystemDefaults.TextStyles.BodyText
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Left
            translationX: 80
            translationY: 40
        }
        TextArea {
            id: fileLabel
            editable: false
            visible: false
            text: ""
            textStyle.base: SystemDefaults.TextStyles.BodyText
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Left
            translationX: 80
            translationY: 360
        }
    }
    function fileActions() {
        theNextStep.text = qsTr("You have selected the file below.\nEmbed the card from ODS:\nCloud Action (Previewer/Composer)\nor Share Action (Previewer)") + Retranslate.onLanguageChanged
        fileLabel.text = picker.selectedFile
        fileLabel.visible = true
        page.addAction(cloudActionPreviewer, 0)
        page.addAction(cloudActionComposer, 1)
        page.addAction(shareAction, 2)
        //cloudActionPreviewer.enabled = true
        //cloudActionComposer.enabled = true
        //shareAction.enabled = true
    }
    function resetFields() {
        fileLabel.visible = false
        page.removeAction(cloudActionPreviewer)
        page.removeAction(cloudActionComposer)
        page.removeAction(shareAction)
        //cloudActionPreviewer.enabled = false
        //cloudActionComposer.enabled = false
        //shareAction.enabled = false
        theNextStep.text = qsTr("Select a file from Overflow Menu:\n\nDocument, Image,\nVideo or Music)\n\nor invoke ODS as Application:\nOpen in... Action") + Retranslate.onLanguageChanged
    }
    function onGreen() {
        redImage.visible = false
        greenImage.visible = true
    }
    function onRed() {
        greenImage.visible = false
        redImage.visible = true
    }
    onCreationCompleted: {
        // support all orientations
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
        // connect to results
        app.cardSuccess.connect(onGreen)
        app.cardCanceled.connect(onRed)
        resetFields();
    }
}
