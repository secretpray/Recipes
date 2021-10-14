import React from "react"

class SearchBar extends React.Component {
  constructor(props) {
    super(props)
  }

  render () {
    return (
      <form action="/autosearch" acceptCharset="UTF-8" method="get">
        <input name="utf8" type="hidden" value="√" />
        <button name="button" type="submit">
          <i className="fa fa-search" id='searchbar-icon'></i>
        </button>
        <input
          onFocus={() => this.props.showDropdown()}
          onBlur={() => this.props.hideDropdown()}
          value={this.props.term}
          onChange={(event) => {this.handleInputChange(event.target.value)}}
          placeholder="Search"
          autoComplete="off"
          type="search"
          name="search[q]"
          className='ps-5 py-1 nav-link'
          id="search_q" />
      </form>
    );
  }

  handleInputChange(term) {
    this.props.onSearchTermChange(term);
  }
}

export default SearchBar
