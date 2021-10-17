import React, {useState, useEffect, useReducer} from 'react'
import SearchBar from "./SearchBar"
import SearchResultsList from "./SearchResultsList"
import loader from '../../assets/images/loader/spinner6.gif'


const baseURL = 'react_autosearch?term='
const configFetch = {
  method: 'GET',
  headers: {
    "Content-Type": "application/json",
    "Accept": "application/json"
  }
}

export const ACTIONS = {
  CHANGE_TERM: 'change-term',
  FETCHED: 'fetched',
  PREVENT_HIDE_DROPDOWN: 'prevent-hide-dropdown',
  SHOW_DROPDOWN: 'show-dropdown'
}

const initialState = {
  preventHideDropdown: false,
  showDropdown: true,
  term: '',
  recipes: [],
  users: [],
  tags: []
}

const styleLoader = { width: '25px',
                      objectFit: 'scale-down',
                      position: 'absolute',
                      opacity:'0.4',
                      align: 'middle',
                      left: '64%',
                      margin: '5px'}

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
      throw new Error(`${action.type} - not found!`);
  }
}

const AutocompleteSearch = () => {
  const [state, dispatch] = useReducer(reducer, initialState)
  const [isLoading, setIsLoading] = useState(false)
  const [isError, setIsError] = useState(false)

  useEffect(() => {
    let term = state.term

    const search = async (term) => {
      setIsLoading(true)
      const response = await fetch(baseURL + `${term}`, configFetch)
      const { recipes, users, tags } = await response.json()
      dispatch({type: ACTIONS.FETCHED, payload: { recipes, users, tags}})
      setIsLoading(false)
    }

    const debounceSearch = setTimeout(() => {
      if(term?.length > 1) { search(term) }}, 300)
    return () => {clearTimeout(debounceSearch)}
  }, [state.term])

  const renderSearchResults = () => {
    // {isError && <div>Something went wrong ...</div>}
    if(isLoading) {
      return (
        <img src={loader} style={styleLoader} alt="loading..." />
      )
    } else {
      const notContentFound = !state.recipes?.length && !state.users?.length && !state.tags?.length
      if(!state.showDropdown || notContentFound) { return }

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
  }

  return (
    <div>
      <SearchBar term={state.term} dispatch={dispatch}/>
      {renderSearchResults()}
    </div>
  )
}

export default AutocompleteSearch
