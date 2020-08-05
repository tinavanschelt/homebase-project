import React from 'react'
import PropTypes from 'prop-types'
import { logo, prof, iconMenu } from '../helpers/icons'

class TopNav extends React.Component {
    constructor(props) {
        super(props)
        this.state = { menuOpen: false }
        this.toggleNav = this.toggleNav.bind(this)
        this.goToPage = this.goToPage.bind(this)
    }

    toggleNav() {
        this.setState({ menuOpen: !this.state.menuOpen })
    }

    goToPage(path) {
        window.location = `${window.location.origin}/${path}`
    }

    render() {
        const { menuOpen } = this.state

        return (
            <div className="top-nav">
                <div className="top-nav__items">
                    <div className="avatar">
                        <img alt="Profile image" src={prof} />
                    </div>
                    <a href="/">
                        <img className="logo" alt="Homebase logo" src={logo} />
                    </a>
                    <img
                        className="menu"
                        alt="Menu"
                        src={iconMenu}
                        onClick={() => this.toggleNav()}
                    />
                </div>
                {menuOpen && (
                    <div className="nav-pop-up">
                        <div
                            className="nav-pop-up__item"
                            onClick={() => this.goToPage('groups')}
                        >
                            Groups
                        </div>
                        <a
                            className="nav-pop-up__item"
                            href="/users/sign_out"
                            data-method="delete"
                        >
                            Logout
                        </a>
                    </div>
                )}
            </div>
        )
    }
}

TopNav.propTypes = {}

export default TopNav
