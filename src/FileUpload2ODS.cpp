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
#include "FileUpload2ODS.hpp"

#include <bb/cascades/pickers/FilePicker>
#include <bb/cascades/pickers/FilePickerMode>
#include <bb/cascades/pickers/FilePickerSortFlag>
#include <bb/cascades/pickers/FilePickerSortOrder>
#include <bb/cascades/pickers/FileType>
#include <bb/cascades/pickers/FilePickerViewMode>

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>

using namespace bb::cascades;
using namespace bb::system;

FileUpload2ODS::FileUpload2ODS(bb::cascades::Application *app)
: QObject(app), m_invokeManager(new InvokeManager(this))
{

	// Register some classes for Filepicker for QML
		qmlRegisterType<bb::cascades::pickers::FilePicker>("bb.cascades.pickers", 1,
				0, "FilePicker");
		qmlRegisterUncreatableType<bb::cascades::pickers::FilePickerMode>(
				"bb.cascades.pickers", 1, 0, "FilePickerMode", "");
		qmlRegisterUncreatableType<bb::cascades::pickers::FilePickerSortFlag>(
				"bb.cascades.pickers", 1, 0, "FilePickerSortFlag", "");
		qmlRegisterUncreatableType<bb::cascades::pickers::FilePickerSortOrder>(
				"bb.cascades.pickers", 1, 0, "FilePickerSortOrder", "");
		qmlRegisterUncreatableType<bb::cascades::pickers::FileType>(
				"bb.cascades.pickers", 1, 0, "FileType", "");
		qmlRegisterUncreatableType<bb::cascades::pickers::FilePickerViewMode>(
				"bb.cascades.pickers", 1, 0, "FilePickerViewMode", "");

	// create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml->setContextProperty("app", this);

    // create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    // set created root object as a scene
    app->setScene(root);
}

void FileUpload2ODS::invokeBoundODSPreviewer(QString data) {
	InvokeRequest cardRequest;
	cardRequest.setData(data.toLatin1());
	cardRequest.setTarget("io.ods.bb10.card.upload.previewer");
	m_invokeManager->invoke(cardRequest);
}

void FileUpload2ODS::invokeBoundODSComposer(QString data) {
	InvokeRequest cardRequest;
	cardRequest.setData(data.toLatin1());
	cardRequest.setTarget("io.ods.bb10.card.upload.composer");
	m_invokeManager->invoke(cardRequest);
}

