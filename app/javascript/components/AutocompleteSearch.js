import React, {useEffect, useReducer} from 'react'
import SearchBar from "./SearchBar"
import SearchResultsList from "./SearchResultsList"

const initialState = {
  preventHideDropdown: false,
  showDropdown: true,
  term: '',
  recipes: [],
  users: [],
  tags: []
};

const getAttributes = (response) => {
  const { data } = JSON.parse(response || 'false')
  if(Array.isArray(data)) {
    return data.map(o => o.attributes
  )}
}

const reducer = (state, action) => {
  switch (action.type) {
    case 'change-term':
      return { ...state,
              term: action.payload }
    case 'fetched':
      const { recipes, users, tags } = action.payload
      return { ...state,
              recipes: getAttributes(recipes),
              users: getAttributes(users),
              tags: getAttributes(tags) }
    case 'set-prevent-hide-dropdown':
      return { ...state,
               preventHideDropdown: true }
    case 'unset-prevent-hide-dropdown':
      return { ...state,
               preventHideDropdown: false }
    case 'show-dropdown':
      return { ...state,
              showDropdown: true }
    case 'hide-dropdown':
      if(!state.preventHideDropdown) {
        return { ...state,
                showDropdown: false }
      }
    default:
      return state
  }
}

const AutocompleteSearch = (props) => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const search = async (term) => {
    const response = await fetch(`react_autosearch?term=${term}`, {
      method: 'GET',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    })
    const { recipes, users, tags } = await response.json()
    dispatch({type: 'fetched', payload: { recipes, users, tags}})
  }

  useEffect(() => {
    let term = state.term
    if(term?.length > 1) { search(term) }
    }, [state.term]
  )

  const renderSearchResults = () => {
    if(!state.showDropdown || (state.recipes?.length === 0 && state.users?.length === 0 && state.tags?.length === 0)) {
      return;
    }

    return (
      <SearchResultsList
        term={state.term}
        recipes={state.recipes}
        users={state.users}
        tags={state.tags}
        dispatch={dispatch}
      />
    )
  }

  return (
    <div>
      <SearchBar term={state.term} dispatch={dispatch}/>
      {renderSearchResults()}
    </div>
  )
}

export default AutocompleteSearch
