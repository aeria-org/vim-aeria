if (exists('b:current_syntax'))
  finish
endif

" Primitives
syn case match
syn match aeriaComment "\v//.*$"
syn match aeriaBoolean /\<\%(true\|false\)\>/
syn match aeriaIdentifier /\v\w+/
syn region aeriaQuotedString start=/\v"/ skip=/\v\\./ end=/\v"/
syn cluster aeriaConstant contains=aeriaBoolean,aeriaQuotedString

hi def link aeriaComment Comment
hi def link aeriaBoolean Boolean
hi def link aeriaQuotedString String

" Attributes
syn region aeriaAttribute start=/\v\@\w+\(/ end=/)/ contains=aeriaQuotedString,aeriaBoolean
syn match aeriaAttributeShorthand "\v\@\w+(\s|$)"
syn cluster aeriaAttributeCluster contains=aeriaAttribute,aeriaAttributeShorthand

hi def link aeriaAttribute Function
hi def link aeriaAttributeShorthand Function

" Macros
syn region aeriaMacro start=/\v\w+\(/ end=/)/ contains=aeriaQuotedString,aeriaBoolean,aeriaIdentifier
hi def link aeriaMacro Function

" properties
syn region aeriaProperties matchgroup=aeriaPropertiesDelim start=/\v<(properties|additionalProperties)\s*\{/ end=/}/ contains=aeriaComment,aeriaPropertyName transparent fold 
syn region aeriaPropertyObjectType matchgroup=aeriaPropertyObjectTypeDelim start=/{/ end=/}/ contains=aeriaComment,aeriaProperties transparent fold
syn match aeriaPropertyArrayOperator "\[\]" nextgroup=@aeriaPropertyColumn skipwhite skipnl
syn match aeriaPropertyIdentifier "\v[A-Z]\w+" nextgroup=@aeriaAttributeCluster skipwhite skipnl
syn match aeriaPropertyType /\v<(str|num|int|bool|enum|const|date|datetime)>/ nextgroup=@aeriaAttributeCluster skipwhite skipnl
syn cluster aeriaPropertyColumn contains=aeriaPropertyArrayOperator,aeriaPropertyType,aeriaPropertyIdentifier,aeriaPropertyObjectType
syn match aeriaPropertyName /\v\w+/ nextgroup=@aeriaPropertyColumn skipwhite skipnl

hi def link aeriaPropertiesDelim Delimiter
hi def link aeriaPropertyArrayOperator Operator
hi def link aeriaPropertyObjectTypeDelim Delimiter
hi def link aeriaPropertyType Type
hi def link aeriaPropertyIdentifier Identifier

" collection.functions
syn region aeriaCollectionFunctions matchgroup=aeriaCollectionFunctionsDelim start=/\v<functions\s*\{/ end=/}/ contains=aeriaComment,aeriaCollectionFunctionName,aeriaMacro transparent fold
syn match aeriaCollectionFunctionName /\v\w+\??\s+/ nextgroup=@aeriaAttributeCluster skipwhite skipnl

hi def link aeriaCollectionFunctionsDelim Delimiter
hi def link aeriaCollectionFunctionOptionalOperator Operator

" collection.layout
syn region aeriaCollectionLayout matchgroup=aeriaCollectionLayoutDelim start=/\v<layout\s*\{/ end=/}/ contains=aeriaComment,aeriaCollectionLayoutOptions,aeriaCollectionLayoutName transparent fold
syn region aeriaCollectionLayoutOptions matchgroup=aeriaCollectionLayoutOptionsDelim start=/\v<options\s*\{/ end=/}/ transparent fold contains=
  \ aeriaComment,
  \ aeriaCollectionLayoutOptionsTitle,
  \ aeriaCollectionLayoutOptionsPicture,
  \ aeriaCollectionLayoutOptionsBadge,
  \ aeriaCollectionLayoutOptionsInformation,
  \ aeriaCollectionLayoutOptionsActive,
  \ aeriaCollectionLayoutOptionsPicture,
  \ aeriaCollectionLayoutOptionsTranslateBadge
syn match aeriaCollectionLayoutName "\v<name>" nextgroup=aeriaQuotedString skipwhite skipnl
syn match aeriaCollectionLayoutOptionsTitle "\v<title>" nextgroup=aeriaIdentifier skipwhite skipnl
syn match aeriaCollectionLayoutOptionsPicture "\v<picture>" nextgroup=aeriaIdentifier skipwhite skipnl
syn match aeriaCollectionLayoutOptionsBadge "\v<badge>" nextgroup=aeriaIdentifier skipwhite skipnl
syn match aeriaCollectionLayoutOptionsInformation "\v<information>" nextgroup=aeriaIdentifier skipwhite skipnl
syn match aeriaCollectionLayoutOptionsActive "\v<active>" nextgroup=aeriaIdentifier skipwhite skipnl
syn match aeriaCollectionLayoutOptionsTranslateBadge "\v<translateBadge>" nextgroup=aeriaBoolean skipwhite skipnl

hi def link aeriaCollectionLayoutDelim Delimiter
hi def link aeriaCollectionLayoutOptionsDelim Delimiter
hi def link aeriaCollectionLayoutName Keyword
hi def link aeriaCollectionLayoutOptionsTitle Keyword
hi def link aeriaCollectionLayoutOptionsPicture Keyword
hi def link aeriaCollectionLayoutOptionsBadge Keyword
hi def link aeriaCollectionLayoutOptionsInformation Keyword
hi def link aeriaCollectionLayoutOptionsActive Keyword
hi def link aeriaCollectionLayoutOptionsTranslateBadge Keyword

" collection.search
syn region aeriaCollectionSearch matchgroup=aeriaCollectionSearchDelim start=/\v<search\s*\{/ end=/}/ contains=aeriaComment,aeriaCollectionSearchPlaceholder,aeriaCollectionSearchIndexes transparent fold
syn region aeriaCollectionSearchIndexes matchgroup=aeriaCollectionSearchIndexesDelim start=/\v<indexes\s*\{/ end=/}/ contains=aeriaComment,aeriaIdentifier transparent fold
syn match aeriaCollectionSearchPlaceholder "\v<placeholder>" nextgroup=aeriaQuotedString skipwhite skipnl

hi def link aeriaCollectionSearchDelim Delimiter
hi def link aeriaCollectionSearchIndexesDelim Delimiter
hi def link aeriaCollectionSearchPlaceholder Keyword

" collection
syn region aeriaKeyedList matchgroup=aeriaKeyedListDelim start=/\v<(form|filters|immutable|indexes|presets|required|table|tableMeta|writable)\s*\{/ end=/}/ contains=aeriaComment,aeriaIdentifier,@aeriaAttributeCluster transparent fold
syn region aeriaCollection matchgroup=aeriaCollectionDelim start=/\v<collection\s+\w*(\s+extends\s+\w+\.\w+)?\s*\{/ end=/}/ transparent fold contains=
  \ aeriaComment,
  \ aeriaProperties,
  \ aeriaKeyedList,
  \ aeriaCollectionModifierName,
  \ aeriaCollectionFunctions,
  \ aeriaCollectionLayout,
  \ aeriaCollectionSearch transparent
syn match aeriaCollectionModifierName "\v<(owned|timestamps|icon)>" nextgroup=@aeriaConstant skipwhite skipnl

hi def link aeriaKeyedListDelim Delimiter
hi def link aeriaCollectionDelim Delimiter
hi def link aeriaCollectionModifierName Keyword

syn region aeriaFunctionSet matchgroup=aeriaFunctionSetDelim start=/\v<functionset>\s+\w+\s*\{/ end=/}/ contains=aeriaComment,aeriaCollectionFunctionName transparent fold
hi def link aeriaFunctionSetDelim Delimiter

let b:current_syntax = "aeria"

