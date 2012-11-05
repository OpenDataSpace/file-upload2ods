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
            }
        }
    ]
    actions: [
        ActionItem {
            title: qsTr("OpenDataSpace") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/ics/4-collections-cloud_newLabel81.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                // TODO Bound Invocation
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
        id: theBar
        title: qsTr("Upload Files to ODS")
        visibility: ChromeVisibility.Visible
    }
    Container {
        layout: DockLayout {
        }
        Label {
            id: fileLabel
            text: qsTr("[selected file]")
            textStyle.base: SystemDefaults.TextStyles.BodyText
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
}
