import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQml.Models 2.1
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import "blocks"

// editor
Rectangle {
	id: editor

	anchors.fill: parent
	color: "#44285a"
	visible: block !== null

	// FIXME: still a problem?
	// to block events from going to the scene
	PinchArea {
		anchors.fill: parent
	}
	MouseArea {
		anchors.fill: parent
		onWheel: wheel.accepted = true;
	}

	property Block block: null
	property BlockDefinition definition: null

	function setBlock(block) {
		editor.block = block;
		editorItemLoader.defaultParams = block.params;
		editor.definition = block.definition;
	}

	function setBlockType(definition) {
		editorItemLoader.defaultParams = definition.defaultParams;
		editor.definition = definition;
	}

	function clearBlock() {
		editor.block = null;
		editor.definition = null;
	}

	Loader {
		id: editorItemLoader
		anchors.centerIn: parent
		scale: Math.max(scaledWidth / 256, 0.1)
		// FIXME: this is binded so that when it is changed just before setting the definition it generates errors
		property var defaultParams

		//property real scaledWidth: Math.min(parent.width, parent.height - (cancelButton.height+12+12)*2)
		property real scaledWidth: Math.min(parent.width-48*2, parent.height-24)

		sourceComponent: editor.definition ? editor.definition.editor : null
	}

	property real horizontalButtonMargin: ((width - editorItemLoader.scaledWidth) - 48) / 4

//	// buttons of the fake dialog
//	RowLayout {
//		anchors.bottom: parent.bottom
//		anchors.bottomMargin: 12
//		anchors.horizontalCenter: parent.horizontalCenter
//		spacing: 24

//		Button {
//			id: cancelButton
//			text: "Cancel"

//	//		contentItem: Image{
//	//			source: "images/okButton.svg"
//	//		}

//			onClicked: {
//				clearBlock();
//			}
//		}

//		Button {
//			text: "Ok"

//	//		contentItem: Image{
//	//			source: "images/okButton.svg"
//	//		}

//			onClicked: {
//				block.definition = editor.definition;
//				block.params = editorItemLoader.item.getParams();
//				clearBlock();
//			}
//		}
//	}

	HDPIImage {
		/*anchors.bottom: parent.bottom
		anchors.bottomMargin: 12*/
		anchors.right: parent.right
		anchors.rightMargin: horizontalButtonMargin
		anchors.verticalCenter: parent.verticalCenter
		source: "icons/ic_done_white_24px.svg"
		width: 24 // working around Qt bug with SVG and HiDPI
		height: 24 // working around Qt bug with SVG and HiDPI
		MouseArea {
			anchors.fill: parent
			onClicked: {
				block.definition = editor.definition;
				block.params = editorItemLoader.item.getParams();
				clearBlock();
			}
		}
	}

	HDPIImage {
		/*anchors.top: parent.top
		anchors.topMargin: 12
		anchors.right: parent.right
		anchors.rightMargin: 12*/
		anchors.left: parent.left
		anchors.leftMargin: horizontalButtonMargin
		anchors.verticalCenter: parent.verticalCenter
		source: "icons/ic_cancel_white_24px.svg"
		width: 24 // working around Qt bug with SVG and HiDPI
		height: 24 // working around Qt bug with SVG and HiDPI
		MouseArea {
			anchors.fill: parent
			onClicked: {
				clearBlock();
			}
		}
	}
}
