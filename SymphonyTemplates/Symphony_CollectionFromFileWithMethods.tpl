<CODEGEN_FILENAME><Structure_name>_CollectionFromFile.CodeGen.dbc</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>SELECTIONDESCRIPTION</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SELECTIONFIELD</REQUIRES_USERTOKEN>
<OPTIONAL_USERTOKEN>RPSDATAFILES= </OPTIONAL_USERTOKEN>
<OPTIONAL_USERTOKEN>TRIMFUNCTION= </OPTIONAL_USERTOKEN>
;//****************************************************************************
;//
;// Title:       Symphony_CollectionFromFile.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to provide selection collections based of file contents
;//
;// Author:      Richard C. Morris, Synergex Professional Services Group
;//
;// Copyright (c) 2012, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;//****************************************************************************
;;****************************************************************************
;;
;; WARNING: This code was generated by CodeGen. Any changes that you
;;          make to this code will be overwritten if the code is regenerated!
;;
;; Template author:	Richard C. Morris, Synergex Professional Services Group
;;
;; Template Name:	Symphony Framework : <TEMPLATE>.tpl
;;
;;****************************************************************************

import System
import System.Collections.Generic
import System.Text

import Symphony.Conductor.DataIO
import Symphony.Conductor.Content

<FILEIFEXIST:TPLINC:namespace.inc>

namespace <NAMESPACE>

	public class <STRUCTURE_NAME>_Collection extends SelectionItemList

		public method <STRUCTURE_NAME>_Collection
			endparams
		proc

			if (internalList == ^null)
				<NAMESPACE>.<STRUCTURE_NAME>_Collection.buildInternalList()

			data item	,@SelectionItem

			foreach item in internalList
			begin
				this.add(item)
			end

		endmethod

		private static internalList	,@SelectionItemList

		private static method buildInternalList	,void
			endparams

		.include '<structure_name>' repository <RPSDATAFILES>, record='<structure_name>'

		proc
			data dObj	,@<Structure_name>_Data	,new <Structure_name>_Data()
			data dIO	,@<Structure_name>_FileIO

			internalList = new SelectionItemList()

			try
			begin
				dIO = new <Structure_name>_FileIO()
				data result	,FileAccessResults
				result = dIO.ReadFirstRecord(dObj)
				while (result == FileAccessResults.Success)
				begin
					<Structure_name> = dObj.SynergyRecord
					internalList.Add(new SelectionItem((string)<Structure_name>.<SELECTIONDESCRIPTION>, <TRIMFUNCTION>(<Structure_name>.<SELECTIONFIELD>)))
					result = dIO.ReadNextRecord(dObj)
				end
			end
			catch (e, @Exception)
			begin
				internalList.Add(new SelectionItem("<No items to display>"))
			end
			endtry
		endmethod
		
		public method SelectMethod	,@List<SelectionItem>
		proc
			mreturn this
		endmethod

	endclass
endnamespace


