import React from "react"
import SearchRecipeListItem from "./SearchRecipeListItem"
import SearchUserListItem from "./SearchUserListItem"
import SearchTagListItem from "./SearchTagListItem"

class SearchResultsList extends React.Component {

  render() {
    return (
      <ul className="dropdown-menu" id="autocomplete-items" onMouseEnter={() => {this.props.setPreventHideDropdown()}} onMouseLeave={() => {this.props.resetPreventHideDropdown()}}>
        <span className="dropdown-arrow-top"></span>
        <span className="dropdown-arrow-bottom"></span>
        <li>
          <a className='text-decoration-none' href={`/search?q=${this.props.term}`}>
            <i className="fa fa-search"></i> Search for <strong>{this.props.term}</strong>
          </a>
        </li>
        {this.renderRecipeHeading()}
        {this.renderRecipes()}
        {this.renderUserHeading()}
        {this.renderUsers()}
        {this.renderTagHeading()}
        {this.renderTags()}
      </ul>
    );
  }

  renderRecipes() {
   return this.props.recipes?.slice(0, 3).map((recipe) => {
      return <SearchRecipeListItem key={recipe.id} recipe={recipe} />
    });
  }

  renderUsers() {
    return this.props.users?.slice(0, 3).map((user) => {
      return <SearchUserListItem key={user.id} user={user} />
    });
  }

  renderTags() {
    return this.props.tags?.slice(0, 3).map((tag) => {
      return <SearchTagListItem key={tag.id} tag={tag} />
    });
  }

  renderRecipeHeading() {
    if (this.props.recipes?.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Recipes</h4></li>
  }

  renderUserHeading() {
    if (this.props.users?.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>People</h4></li>
  }

  renderTagHeading() {
    if (this.props.tags?.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Tags</h4></li>
  }
}

export default SearchResultsList