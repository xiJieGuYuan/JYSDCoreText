/**
 * Created by Admin on 2017/3/1.
 */
import React, { Component} from 'react';
import {StyleSheet,Platform} from 'react-native';
import { Router, Scene,ActionConst,Actions } from 'react-native-router-flux';//引入包
import { connect } from 'react-redux';
import Login from '../pages/Login'; //登录
import PatientOrder from '../pages/private_hospital/PatientOrderList'; //1
import Find from '../pages/private_hospital/Find'; //3
import AboutMe from '../pages/private_hospital/AboutMe'; //4
import FirstStep from '../pages/private_hospital/FirstStep'; //4
import ForgetPassword from '../pages/ForgetPassword'; //4
import Register from '../pages/Register'; //4s
import SecondStep from '../pages/private_hospital/SecondStep'; //5
import ApproveStatus from '../pages/private_hospital/ApproveStatus'; //6 资质认证的状态
import UserFeedBack from '../pages/private_hospital/UserFeedBack'; //7 用户反馈
import UserSetting from '../pages/private_hospital/UserSetting'; //8 用户设置
import SecureSetting from '../pages/private_hospital/SecureSetting'; //9 密码设置
import AlterPassWord from '../pages/private_hospital/AlterPassWord'; //10 修改密码
import AboutYouYiChi from '../pages/private_hospital/AboutYouYiChi'; //11 关于优益齿
import PatientOrderDetail from '../pages/private_hospital/PatientOrderDetail'; //12 预约详情
import MyPatient from '../pages/public_hospital/MyPatient'; //12 预约详情
import FindPublic from '../pages/public_hospital/FindPublic'
import AboutMePublic from '../pages/public_hospital/AboutMePublic'
import PatientDetail from '../pages/public_hospital/PatientDetail'
import ImportPatient from '../pages/public_hospital/ImportPatient'
import IdentityConfirmStep1 from '../pages/IdentityConfirmStep1'
import IdentityConfirmStep2 from '../pages/IdentityConfirmStep2'
import IdentityConfirmPending from '../pages/IdentityConfirmPending'
import IdentityConfirmFailed from '../pages/IdentityConfirmFailed'
import IdentityConfirmSuccess from '../pages/IdentityConfirmSuccess'
import LaunchPage from '../pages/LaunchPage'
import MyPatientList from '../pages/private_hospital/MyPatientList'
import MyPatientInfo from '../pages/private_hospital/MyPatientInfo'
import CaseDetail from '../pages/private_hospital/CaseDetail'
import * as colors from '../constants/colors'
import {getPersonalInstance} from '../utils/PersonalInfo';
import TabIcon from '../components/TabIcon';
let Global = require('../constants/Global');
const RouterWithRedux = connect()(Router);


const App = () => {

    return (

        <RouterWithRedux
            navigationBarStyle={styles.navBar}
            titleStyle={styles.navBarTitle}>
            <Scene key="root">


                {/*
                 <Scene
                 key="launchPage"
                 component={LaunchPage}
                 initial
                 type={ActionConst.RESET}
                 hideNavBar
                 hideTabBar/>
                */}

                <Scene
                    key="login"
                    component={Login}
                    type={ActionConst.RESET}
                    hideNavBar
                    hideTabBar/>
                <Scene
                    key="firstStep"
                    component={FirstStep}
                    title="资质认证"
                    hideNavBar
                />
                <Scene
                    key="forgetPassword"
                    component={ForgetPassword}
                    hideNavBar/>
                <Scene
                    key="caseDetail"
                    component={CaseDetail}
                    hideNavBar/>
                <Scene
                    key="secondStep"
                    component={SecondStep}
                    title="资质认证"
                    hideNavBar
                    type={ActionConst.REPLACE}/>
                <Scene
                    key="approveStatus"
                    component={ApproveStatus}
                    title="资质认证"
                    hideNavBar
                    type={ActionConst.REPLACE}
                />
                <Scene
                    key="userFeedBack"
                    component={UserFeedBack}
                    title="用户反馈"
                    hideNavBar/>
                <Scene
                    key="userSetting"
                    component={UserSetting}
                    title="设置"
                    hideNavBar/>
                <Scene
                    key="myPatientInfo"
                    component={MyPatientInfo}
                    title="设置"
                    hideNavBar/>
                <Scene
                    key="secureSetting"
                    component={SecureSetting}
                    title="安全设置"
                    hideNavBar/>
                <Scene
                    key="alterPassWord"
                    component={AlterPassWord}
                    title="修改密码"
                    hideNavBar/>
                <Scene
                    key="aboutYouYiChi"
                    component={AboutYouYiChi}
                    title="关于优益齿"
                    hideNavBar/>
                <Scene
                    key="patientOrderDetail"
                    component={PatientOrderDetail}
                    hideNavBar/>
                <Scene
                    key="identityConfirmStep1"
                    type={ActionConst.REPLACE}
                    component={IdentityConfirmStep1}
                    hideNavBar/>
                <Scene
                    key="identityConfirmStep2"
                    type={ActionConst.REPLACE}
                    component={IdentityConfirmStep2}
                    hideNavBar/>
                <Scene
                    key="identityConfirmPending"
                    type={ActionConst.REPLACE}
                    component={IdentityConfirmPending}
                    hideNavBar/>
                <Scene
                    key="identityConfirmFailed"
                    component={IdentityConfirmFailed}
                    hideNavBar/>
                <Scene
                    key="identityConfirmSuccess"
                    component={IdentityConfirmSuccess}
                    hideNavBar/>
                <Scene
                    key="patientDetail"
                    component={PatientDetail}
                    hideNavBar/>

                <Scene
                    key="importPatient"
                    component={ImportPatient}
                    hideNavBar/>
                <Scene
                    key="register"
                    component={Register}
                    hideNavBar/>


                <Scene key="homepage"   tabs={true} style={styles.barStyle} pressOpacity={0.8} type={ActionConst.REPLACE}>

                    <Scene
                        key="patientOrder"
                        component={PatientOrder}
                        icon={TabIcon}
                        title="预约"
                        hideNavBar
                        iconName="homepage_order"/>

                    <Scene
                        key="myPatientList"
                        component={MyPatientList}
                        title="患者"
                        showReadDot={true}
                        hideNavBar
                        icon={TabIcon}
                        iconName="homepage_patient"/>


                    {/*
                     <Scene
                     key="find"
                     component={Find}
                     title="发现"
                     hideNavBar
                     icon={TabIcon}
                     iconName="homepage_find"/>
                    */}

                    <Scene

                        key="aboutMe"
                        component={AboutMe}
                        hideNavBar
                        title="我的"
                        icon={TabIcon}
                        iconName="homepage_me"/>
                </Scene>

                <Scene key="homepagePublic" tabs={true} style={styles.barStyle} pressOpacity={0.8}
                       type={ActionConst.REPLACE}>
                    <Scene
                        key="myPatient"
                        component={MyPatient}
                        title="患者"
                        hideNavBar
                        icon={TabIcon}
                        iconName="homepage_patient"/>
                    <Scene
                        key="findPublic"
                        component={FindPublic}
                        title="发现"
                        icon={TabIcon}
                        hideNavBar
                        iconName="homepage_find"/>
                    <Scene
                        key="aboutMePublic"
                        component={AboutMePublic}
                        hideNavBar
                        title="我的"
                        icon={TabIcon}
                        iconName="homepage_me"/>
                </Scene>
            </Scene>
        </RouterWithRedux>
    );
}

const styles = StyleSheet.create({
    navBar: {
        backgroundColor: colors.green,
        height: Platform.OS === 'ios' ? 64 : 50
    },
    navBarTitle: {
        color: colors.white,
        fontSize: Platform.OS === 'ios' ? 18 : 15
    },
    barStyle: {
        height: 50,
        borderTopColor: colors.gray_line,
        borderTopWidth: 1 / Global.mPixelRatio,
        backgroundColor: colors.white
    }
});

export default App;