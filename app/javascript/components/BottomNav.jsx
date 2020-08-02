import React from 'react'
import PropTypes from 'prop-types'
import {
    iconFlag,
    iconSmile,
    iconCalendar,
    iconPlus,
    iconPlusInverted,
} from '../helpers/icons'

class BottomNav extends React.Component {
    constructor(props) {
        super(props)
        this.state = { popupOpen: false }
        this.togglePopup = this.togglePopup.bind(this)
    }

    togglePopup() {
        this.setState({ popupOpen: !this.state.popupOpen })
    }

    render() {
        const { popupOpen } = this.state

        return (
            <div className="bottom-nav">
                {popupOpen && (
                    <div className="bottom-nav__pop-up">
                        <div className="bottom-nav__pop-up__item">
                            <img src={iconPlusInverted} alt="New Event" />
                            Create New Event
                        </div>
                        <div className="bottom-nav__pop-up__item">
                            <img src={iconPlusInverted} alt="New Task" />
                            Create New Task
                        </div>
                    </div>
                )}
                <div className="bottom-nav__items">
                    <span className="bottom-nav__items__item">
                        <img src={iconFlag} alt="Home" />
                        Home
                    </span>
                    <span className="bottom-nav__items__item">
                        <img src={iconSmile} alt="My Stuff" />
                        My Stuff
                    </span>
                    <span className="bottom-nav__items__item">
                        <img src={iconCalendar} alt="Calendar" />
                        Calendar
                    </span>
                    <span
                        className="bottom-nav__items__item"
                        onClick={() => this.togglePopup()}
                    >
                        <img src={iconPlus} alt="New" />
                        New
                    </span>
                </div>
            </div>
        )
    }
}

BottomNav.propTypes = {}

export default BottomNav
