import React from "react"
import { ACTIONS } from "./AutocompleteSearch"
import SearchRecipeListItem from "./SearchRecipeListItem"
import SearchUserListItem from "./SearchUserListItem"
import SearchTagListItem from "./SearchTagListItem"

const SearchResultsList = ({ term, recipes, users, tags, dispatch }) => {

  const renderRecipes = () => {
   return recipes?.slice(0, 3).map((recipe) => {
      return <SearchRecipeListItem key={recipe.id} recipe={recipe} />
    });
  }

  const renderUsers = () => {
    return users?.slice(0, 3).map((user) => {
      return <SearchUserListItem key={user.id} user={user} />
    });
  }

  const renderTags = () => {
    return tags?.slice(0, 3).map((tag) => {
      return <SearchTagListItem key={tag.id} tag={tag} />
    });
  }

  const renderRecipeHeading = () => {
    if (!recipes.length) { return; }

    return <li className="autocomplete-heading"><h4>Recipes</h4></li>
  }

  const renderUserHeading = () => {
    if (!users.length) { return; }

    return <li className="autocomplete-heading"><h4>People</h4></li>
  }

  const renderTagHeading = () => {
    if (!tags.length) { return; }

    return <li className="autocomplete-heading"><h4>Tags</h4></li>
  }

  return (
    <ul className="dropdown-menu" id="autocomplete-items" onMouseEnter={() => {dispatch({type: ACTIONS.PREVENT_HIDE_DROPDOWN, payload: true })}} onMouseLeave={() => {dispatch({type: ACTIONS.PREVENT_HIDE_DROPDOWN, payload: false })}}>
      <span className="dropdown-arrow-top"></span>
      <span className="dropdown-arrow-bottom"></span>
      <li>
        <a className='text-decoration-none' href={`/search?q=${term}`}>
          <i className="fa fa-search"></i> Search for <strong>{term}</strong>
        </a>
      </li>
      {renderRecipeHeading()}
      {renderRecipes()}
      {renderUserHeading()}
      {renderUsers()}
      {renderTagHeading()}
      {renderTags()}
    </ul>
  )
}

export default SearchResultsList
