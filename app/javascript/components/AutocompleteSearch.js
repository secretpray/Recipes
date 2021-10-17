import React, {useState, useEffect, useReducer} from 'react'
import SearchBar from "./SearchBar"
import SearchResultsList from "./SearchResultsList"

export const ACTIONS = {
  CHANGE_TERM: 'change-term',
  FETCHED: 'fetched',
  LOADING: 'isloading',
  PREVENT_HIDE_DROPDOWN: 'prevent-hide-dropdown',
  SHOW_DROPDOWN: 'show-dropdown'
}

const initialState = {
  preventHideDropdown: false,
  showDropdown: true,
  isloading: false,
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
    case ACTIONS.LOADING:
      return { ...state, isloading: action.payload }
    case ACTIONS.FETCHED:
      const { recipes, users, tags } = action.payload
      return { ...state,
              recipes: getAttributes(recipes),
              users: getAttributes(users),
              tags: getAttributes(tags) }
    case ACTIONS.PREVENT_HIDE_DROPDOWN:
      return { ...state,
               preventHideDropdown: action.payload }
    case ACTIONS.SHOW_DROPDOWN:
      if(action.payload) {
        return { ...state,
          showDropdown: action.payload }
      } else if (!state.preventHideDropdown) {
        return { ...state,
          showDropdown: action.payload }
      } else {
        return state
      }
    default:
      throw new Error(`${action.type} - not found!`)
  }
}

const AutocompleteSearch = (props) => {
  const [state, dispatch] = useReducer(reducer, initialState);

  const search = (term) => {
    fetch(`react_autosearch?term=${term}`)
      .then(response => response.json())
      .then(data => {
        const { recipes, users, tags } = data
        dispatch({type: ACTIONS.FETCHED, payload: { recipes, users, tags }})
      })
  }

  useEffect(() => {
    let term = state.term
    const debounceSearch = setTimeout(() => {
      if(term?.length > 1) {
        search(term)
      }
    }, 300)
    return () => {
      clearTimeout(debounceSearch)
    }
  }, [state.term])

  const renderSearchResults = () => {

    const anyContentPresent = !state.recipes?.length && !state.users?.length && !state.tags?.length
    if(!state.showDropdown || anyContentPresent) { return }

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
