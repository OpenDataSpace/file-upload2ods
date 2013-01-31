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
#ifndef FileUpload2ODS_HPP_
#define FileUpload2ODS_HPP_

#include <QObject>
#include <bb/system/InvokeManager.hpp>
#include <bb/system/InvokeRequest.hpp>
#include <bb/system/CardDoneMessage>

namespace bb {
namespace cascades {
class Application;
}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class FileUpload2ODS: public QObject {
Q_OBJECT
public:
	FileUpload2ODS(bb::cascades::Application *app);
	virtual ~FileUpload2ODS() {
	}

	/**
	 * uses Invokation Framework to Invoke embedded Card
	 * as Previewer
	 */
	Q_INVOKABLE
	void invokeBoundODSUpload(QString data);


Q_SIGNALS:

	void cardSuccess();
	void cardCanceled();

private Q_SLOTS:
	// This slot updates the status message when the invocation of a card is done
	void childCardDone(const bb::system::CardDoneMessage&);

private:
	bb::system::InvokeManager *m_invokeManager;

};

#endif /* FileUpload2ODS_HPP_ */
