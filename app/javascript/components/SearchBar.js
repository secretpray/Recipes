import React from "react"
import { ACTIONS } from "./AutocompleteSearch"

const SearchBar = (props) => {
  const handleInputChange = (term) => {
    props.dispatch({type: ACTIONS.CHANGE_TERM, payload: term })
  }

  return (
    <form action="/autosearch" acceptCharset="UTF-8" method="get">
      <input name="utf8" type="hidden" value="√" />
      <button name="button" type="submit">
        <i className="fa fa-search" id='searchbar-icon'></i>
      </button>
      <input
        onFocus={() => props.dispatch({type: ACTIONS.SHOW_DROPDOWN})}
        onBlur={() => props.dispatch({type: ACTIONS.HIDE_DROPDOWN})}
        value={props.term}
        onChange={(event) => {handleInputChange(event.target.value)}}
        placeholder="Search"
        autoComplete="off"
        type="search"
        name="search[q]"
        className='ps-5 py-1 nav-link'
        id="search_q" />
    </form>
  )
}

export default SearchBar
