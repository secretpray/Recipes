import React, {useState} from 'react'
import SearchBar from "./SearchBar"
import SearchResultsList from "./SearchResultsList"

const AutocompleteSearch = (props) => {
  const [preventHideDropdown, setPreventHideDropdown] = useState(false)
  const [showDropdown, setShowDropdown] = useState(true)
  const [term, setTerm] = useState('')
  const [recipes, setRecipes] = useState([])
  const [users, setUsers] = useState([])
  const [tags, setTags] = useState([])

  function getAttributes(response) {
    const { data } = JSON.parse(response || 'false')
    if(Array.isArray(data)) {
      return data.map(o => o.attributes
    )}
  }

  function search(term) {
    setTerm(term)

    Rails.ajax({
      type: "GET",
      url: `react_autosearch?term=${term}`,
      dataType: "json",
      success: ({ recipes, users, tags } ) => {
        setRecipes(getAttributes(recipes)),
        setUsers(getAttributes(users)),
        setTags(getAttributes(tags))
      }
    })
  }

  function setnowPreventHideDropdown() {
    setPreventHideDropdown(true)
  }

  function resetPreventHideDropdown() {
    setPreventHideDropdown(false)
  }

  function hideDropdown() {
    if (!preventHideDropdown) {
      setShowDropdown(false)
    }
  }

  function shownowDropdown() {
    setShowDropdown(true)
  }

  return (
    <div>
      <SearchBar
        showDropdown={shownowDropdown}
        hideDropdown={hideDropdown}
        term={term}
        onSearchTermChange={(term) => {search(term)}}
      />
      {renderSearchResults()}
    </div>
  );

  function renderSearchResults() {
    if(!showDropdown || (recipes?.length === 0 && users?.length === 0 && tags?.length === 0)) {
      return;
    }

    return (
      <SearchResultsList
        setPreventHideDropdown={setnowPreventHideDropdown}
        resetPreventHideDropdown={resetPreventHideDropdown}
        term={term}
        recipes={recipes}
        users={users}
        tags={tags}
      />
    );
  }
}

export default AutocompleteSearch
