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
                fileLabel.text = selectedFile
                cloudAction.enabled = true
                shareAction.enabled = true
            }
        }
    ]
    actions: [
        ActionItem {
            id: cloudAction
            title: qsTr("ODS") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/4-collections-cloud_newLabel81.png"
            enabled: false
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                app.invokeBoundODSPreviewer(picker.selectedFile)
            }
        },
        InvokeActionItem {
            id: shareAction
            enabled: false
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
            }
        },
        InvokeActionItem {
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
    titleBar: {
        title: qsTr("Invoke ODS as Card vs App") + Retranslate.onLanguageChanged
    }
    Container {
        layout: DockLayout {
        }
        TextArea {
            id: fileLabel
            editable: false
            text: qsTr("[selected file]")
            textStyle.base: SystemDefaults.TextStyles.BodyText
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
    onCreationCompleted: {
        // support all orientations
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
    }
}
