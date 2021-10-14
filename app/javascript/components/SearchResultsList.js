import React from "react"
import SearchRecipeListItem from "./SearchRecipeListItem"
import SearchUserListItem from "./SearchUserListItem"
import SearchTagListItem from "./SearchTagListItem"

const SearchResultsList = (props) => {
  const renderRecipes = () => {
   return props.recipes?.slice(0, 3).map((recipe) => {
      return <SearchRecipeListItem key={recipe.id} recipe={recipe} />
    });
  }

  const renderUsers = () => {
    return props.users?.slice(0, 3).map((user) => {
      return <SearchUserListItem key={user.id} user={user} />
    });
  }

  const renderTags = () => {
    return props.tags?.slice(0, 3).map((tag) => {
      return <SearchTagListItem key={tag.id} tag={tag} />
    });
  }

  const renderRecipeHeading = () => {
    if (props.recipes?.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Recipes</h4></li>
  }

  const renderUserHeading = () => {
    if (props.users?.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>People</h4></li>
  }

  const renderTagHeading = () => {
    if (props.tags?.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Tags</h4></li>
  }

  return (
    <ul className="dropdown-menu" id="autocomplete-items" onMouseEnter={() => {props.setPreventHideDropdown()}} onMouseLeave={() => {props.resetPreventHideDropdown()}}>
      <span className="dropdown-arrow-top"></span>
      <span className="dropdown-arrow-bottom"></span>
      <li>
        <a className='text-decoration-none' href={`/search?q=${props.term}`}>
          <i className="fa fa-search"></i> Search for <strong>{props.term}</strong>
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
