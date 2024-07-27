if (exists('b:current_syntax'))
  finish
endif

" Primitives
syn case match
syn match aeriaComment "\v//.*$"
syn match aeriaBoolean /\<\%(true\|false\)\>/
syn match aeriaIdentifier /\v\w+/
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

" collection.layout
syn region aeriaCollectionLayout matchgroup=aeriaCollectionLayoutDelim start=/\v<layout\s*\{/ end=/}/ contains=aeriaComment,aeriaCollectionLayoutOptions,aeriaCollectionLayoutName transparent
syn region aeriaCollectionLayoutOptions matchgroup=aeriaCollectionLayoutOptionsDelim start=/\v<options\s*\{/ end=/}/ contains=
  \ aeriaComment,
  \ aeriaCollectionLayoutOptionsTitle,
  \ aeriaCollectionLayoutOptionsPicture,
  \ aeriaCollectionLayoutOptionsBadge,
  \ aeriaCollectionLayoutOptionsInformation,
  \ aeriaCollectionLayoutOptionsActive,
  \ aeriaCollectionLayoutOptionsPicture,
  \ aeriaCollectionLayoutOptionsTranslateBadge
syn match aeriaCollectionLayoutName "\v<name>" nextgroup=aeriaString skipwhite
syn match aeriaCollectionLayoutOptionsTitle "\v<title>" nextgroup=aeriaIdentifier skipwhite
syn match aeriaCollectionLayoutOptionsPicture "\v<picture>" nextgroup=aeriaIdentifier skipwhite
syn match aeriaCollectionLayoutOptionsBadge "\v<badge>" nextgroup=aeriaIdentifier skipwhite
syn match aeriaCollectionLayoutOptionsInformation "\v<information>" nextgroup=aeriaIdentifier skipwhite
syn match aeriaCollectionLayoutOptionsActive "\v<active>" nextgroup=aeriaIdentifier skipwhite
syn match aeriaCollectionLayoutOptionsTranslateBadge "\v<translateBadge>" nextgroup=aeriaBoolean skipwhite

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
syn region aeriaCollectionSearch matchgroup=aeriaCollectionSearchDelim start=/\v<search\s*\{/ end=/}/ contains=aeriaComment,aeriaCollectionSearchPlaceholder,aeriaCollectionSearchIndexes transparent
syn region aeriaCollectionSearchIndexes matchgroup=aeriaCollectionSearchIndexesDelim start=/\v<indexes\s*\{/ end=/}/ contains=aeriaComment,aeriaIdentifier transparent
syn match aeriaCollectionSearchPlaceholder "\v<placeholder>" nextgroup=aeriaString skipwhite

hi def link aeriaCollectionSearchDelim Delimiter
hi def link aeriaCollectionSearchIndexesDelim Delimiter
hi def link aeriaCollectionSearchPlaceholder Keyword

" collection
syn region aeriaKeyedList matchgroup=aeriaKeyedListDelim start=/\v<(form|filters|immutable|indexes|presets|required|table|tableMeta|writable)\s*\{/ end=/}/ contains=aeriaComment,aeriaIdentifier,@aeriaAttributeCluster transparent
syn region aeriaCollection matchgroup=aeriaCollectionDelim start=/\v<collection\s+\w*(\s+extends\s+\w+)?\s*\{/ end=/}/ contains=
  \ aeriaComment,
  \ aeriaProperties,
  \ aeriaKeyedList,
  \ aeriaCollectionModifierName,
  \ aeriaCollectionFunctions,
  \ aeriaCollectionLayout,
  \ aeriaCollectionSearch transparent
syn match aeriaCollectionModifierName "\v<(owned|timestamps|icon)" nextgroup=@aeriaConstant skipwhite

hi def link aeriaKeyedListDelim Delimiter
hi def link aeriaCollectionDelim Delimiter
hi def link aeriaCollectionModifierName Keyword

let b:current_syntax = "aeria"

