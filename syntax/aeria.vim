if (exists('b:current_syntax'))
  finish
endif

" Primitives
syn case match
syn match aeriaComment "\v//.*$"
syn match aeriaBoolean /\<\%(true\|false\)\>/
syn region aeriaString start=/\v"/ skip=/\v\\./ end=/\v"/
syn cluster aeriaConstant contains=aeriaBoolean,aeriaString

hi def link aeriaComment Comment
hi def link aeriaBoolean Boolean
hi def link aeriaString String

" Attributes
syn region aeriaAttribute start=/\v\@\w+\(/ end=/)/ contains=aeriaString,aeriaBoolean
syn match aeriaAttributeShorthand "\v\@\w+(\s|$)"
syn cluster aeriaAttributeCluster contains=aeriaAttribute,aeriaAttributeShorthand

hi def link aeriaAttribute Function
hi def link aeriaAttributeShorthand Function


" properties
syn region aeriaProperties matchgroup=aeriaPropertiesDelim start=/\v<(properties|additionalProperties)\s*\{/ end=/}/ contains=aeriaComment,aeriaPropertyName transparent
syn region aeriaPropertyObjectType matchgroup=aeriaPropertyObjectTypeDelim start=/{/ end=/}/ contains=aeriaComment,aeriaProperties transparent
syn match aeriaPropertyArrayOperator "\[\]" nextgroup=@aeriaPropertyColumn skipwhite
syn match aeriaPropertyIdentifier "\v[A-Z]\w+" nextgroup=@aeriaAttributeCluster skipwhite
syn match aeriaPropertyType /\v<(str|num|int|bool|enum|const)>/ nextgroup=@aeriaAttributeCluster skipwhite
syn cluster aeriaPropertyColumn contains=aeriaPropertyArrayOperator,aeriaPropertyType,aeriaPropertyIdentifier,aeriaPropertyObjectType
syn match aeriaPropertyName /\v\w+/ nextgroup=@aeriaPropertyColumn skipwhite

hi def link aeriaPropertiesDelim Delimiter
hi def link aeriaPropertyArrayOperator Operator
hi def link aeriaPropertyObjectTypeDelim Delimiter
hi def link aeriaPropertyType Type
hi def link aeriaPropertyIdentifier Identifier

" collection.functions
syn region aeriaCollectionFunctions matchgroup=aeriaCollectionFunctionsDelim start=/\v<functions\s*\{/ end=/}/ contains=aeriaComment,aeriaCollectionFunctionName transparent
syn match aeriaCollectionFunctionOptionalOperator "?" nextgroup=@aeriaAttributeCluster skipwhite
syn match aeriaCollectionFunctionName /\v\w+/ nextgroup=aeriaCollectionFunctionOptionalOperator,@aeriaAttributeCluster skipwhite

hi def link aeriaCollectionFunctionsDelim Delimiter
hi def link aeriaCollectionFunctionOptionalOperator Operator

" collection.search
syn region aeriaCollectionSearch matchgroup=aeriaCollectionSearchDelim start=/\v<search\s*\{/ end=/}/ contains=aeriaComment,@aeriaConstant,aeriaCollectionSearchIndexes,aeriaCollectionSearchPlaceholder transparent
syn region aeriaCollectionSearchIndexes matchgroup=aeriaCollectionSearchIndexesDelim start=/\vindexes\s*\{/ end=/}/ contains=aeriaComment,aeriaString transparent
syn match aeriaCollectionSearchPlaceholder "\v<placeholder>" nextgroup=aeriaString skipwhite

hi def link aeriaCollectionSearchDelim Delimiter
hi def link aeriaCollectionSearchIndexesDelim Delimiter
hi def link aeriaCollectionSearchPlaceholder Keyword

" collection
syn region aeriaKeyedList matchgroup=aeriaKeyedListDelim start=/\v<(form|filters|immutable|indexes|presets|required|table|tableMeta|writable)\s*\{/ end=/}/ contains=aeriaComment,aeriaString transparent
syn region aeriaCollection matchgroup=aeriaCollectionDelim start=/\v<collection\s+\w*(\s+extends\s+\w+)?\s*\{/ end=/}/ contains=aeriaComment,@aeriaConstant,aeriaProperties,aeriaKeyedList,aeriaCollectionModifierName,aeriaCollectionFunctions,aeriaCollectionSearch transparent
syn match aeriaCollectionModifierName "\v<(owned|timestamps|icon)" nextgroup=@aeriaConstant skipwhite

hi def link aeriaKeyedListDelim Delimiter
hi def link aeriaCollectionDelim Delimiter
hi def link aeriaCollectionModifierName Keyword

let b:current_syntax = "aeria"

