import React from "react"
// import PropTypes from "prop-types"
import SearchBar from "./SearchBar"
import SearchResultsList from "./SearchResultsList"

class AutocompleteSearch extends React.Component {
  constructor(props) {
    super(props)

    this.state = { preventHideDropdown: false, showDropdown: true, term: '', recipes: [], users: [], tags: [] }
    this.hideDropdown = this.hideDropdown.bind(this);
    this.showDropdown = this.showDropdown.bind(this);
    this.setPreventHideDropdown = this.setPreventHideDropdown.bind(this);
    this.resetPreventHideDropdown = this.resetPreventHideDropdown.bind(this);
  }

  getAttributes(response) {
    const { data } = JSON.parse(response || 'false');
    if(Array.isArray(data)) {return data.map(o => o.attributes)}
  }

  search(term) {
    this.setState({ term });

    Rails.ajax({
      type: "GET",
      url: `react_autosearch?term=${term}`,
      dataType: "json",
      success: ({ recipes, users, tags } ) => {
        this.setState({
        recipes: this.getAttributes(recipes),
        users: this.getAttributes(users),
        tags: this.getAttributes(tags),
      });}
    })
  }

  setPreventHideDropdown() {
    this.setState({ preventHideDropdown: true });
  }

  resetPreventHideDropdown() {
    this.setState({ preventHideDropdown: false });
  }

  hideDropdown() {
    if (!this.state.preventHideDropdown) {
      this.setState({ showDropdown: false });
    }
  }

  showDropdown() {
    this.setState({ showDropdown: true });
  }

  render () {
    return (
      <div>
        <SearchBar
          showDropdown={this.showDropdown}
          hideDropdown={this.hideDropdown}
          term={this.state.term}
          onSearchTermChange={(term) => {this.search(term)}}
        />
        {this.renderSearchResults()}
      </div>
    );
  }

  renderSearchResults() {
    if(!this.state.showDropdown || (this.state.recipes?.length === 0 && this.state.users?.length === 0 && this.state.tags?.length === 0)) {
      return;
    }

    return (
      <SearchResultsList
        setPreventHideDropdown={this.setPreventHideDropdown}
        resetPreventHideDropdown={this.resetPreventHideDropdown}
        term={this.state.term}
        recipes={this.state.recipes}
        users={this.state.users}
        tags={this.state.tags}
      />
    );
  }
}

export default AutocompleteSearch
