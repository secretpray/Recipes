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

  const getAttributes = (response) => {
    const { data } = JSON.parse(response || 'false')
    if(Array.isArray(data)) {
      return data.map(o => o.attributes
    )}
  }

  const search = (term) => {
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

  const setnowPreventHideDropdown = () => {
    setPreventHideDropdown(true)
  }

  const resetPreventHideDropdown = () => {
    setPreventHideDropdown(false)
  }

  const hideDropdown = () => {
    if (!preventHideDropdown) {
      setShowDropdown(false)
    }
  }

  const shownowDropdown = () => {
    setShowDropdown(true)
  }

  const renderSearchResults = () => {
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
    )
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
  )
}

export default AutocompleteSearch
