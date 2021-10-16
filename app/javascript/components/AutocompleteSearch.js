import React, {useEffect, useReducer} from 'react'
import SearchBar from "./SearchBar"
import SearchResultsList from "./SearchResultsList"

export const ACTIONS = {
  CHANGE_TERM: 'change-term',
  FETCHED: 'fetched',
  SET_PREVENT_HIDE_DROPDOWN: 'set-prevent-hide-dropdown',
  UNSET_PREVENT_HIDE_DROPDOWN: 'unset-prevent-hide-dropdown',
  SHOW_DROPDOWN: 'show-dropdown',
  HIDE_DROPDOWN: 'hide-dropdown'
}

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
    case ACTIONS.CHANGE_TERM:
      return { ...state,
              term: action.payload }
    case ACTIONS.FETCHED:
      const { recipes, users, tags } = action.payload
      return { ...state,
              recipes: getAttributes(recipes),
              users: getAttributes(users),
              tags: getAttributes(tags) }
    case ACTIONS.SET_PREVENT_HIDE_DROPDOWN:
      return { ...state,
               preventHideDropdown: true }
    case ACTIONS.UNSET_PREVENT_HIDE_DROPDOWN:
      return { ...state,
               preventHideDropdown: false }
    case ACTIONS.SHOW_DROPDOWN:
      return { ...state,
              showDropdown: true }
    case ACTIONS.HIDE_DROPDOWN:
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
    dispatch({type: ACTIONS.FETCHED, payload: { recipes, users, tags}})
  }

  useEffect(() => {
    let term = state.term

    const debounceSearch = setTimeout(() => {
      if(term?.length > 1) {
        search(term)
      }
    }, 300)
    return () => {
      clearTimeout(debounceSearch);
    }
  }, [state.term])

  const renderSearchResults = () => {
    if(!state.showDropdown || (!state.recipes?.length && !state.users?.length && !state.tags?.length)) {
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
