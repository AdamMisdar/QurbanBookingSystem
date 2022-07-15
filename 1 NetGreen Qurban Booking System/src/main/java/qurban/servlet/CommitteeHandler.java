package qurban.servlet;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import qurban.dao.*;
import qurban.javabean.*;


@WebServlet("/CommitteeHandler")
public class CommitteeHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommitteeManagementDAO comManagementDAO;
	private CommitteeVoluntaryDAO comVoluntaryDAO;
	
	HttpSession session = null;
       

    public CommitteeHandler() {
        super();
        comManagementDAO = new CommitteeManagementDAO();
        comVoluntaryDAO = new CommitteeVoluntaryDAO();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Set content type
		response.setContentType("text/html");
				
		// Get action
		String action = request.getParameter("action");
		System.out.println(action);
		
		// Filter action
		try {
									
			switch(action) {
							
			// Create - Manager creates committee account
			case "createCommittee":
				createCommittee(request, response);
				break;
				
			// ------------------------------------------------	
				
			// Update Management (Manager Only) can fully update this account
			case "updateManagement_ManagerOnly":
				updateManagement_ManagerOnly(request, response);
				break;
				
			// Update Management Account (Normal)
			case "updateManagement":
				updateManagement(request, response);		
				
				
			// Delete Management (Manager Only)
			case "deleteManagement":
				deleteManagement(request, response);
				break;
				
			// 	--------------------------------------------------
				
			// Update Voluntary (Manager Only) can fully update this account
			case "updateVoluntary_ManagerOnly":
				updateVoluntary_ManagerOnly(request, response);
				
			// Update Voluntary (Normal)
			case "updateVoluntary":
				updateVoluntary(request, response);
			
			// Delete Voluntary (Manager Only)
			case "deleteVoluntary":
				deleteVoluntary(request, response);
				
			}
			
									
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}
	
	// Methods -----------------------------------------------
	
	// ############################## ALL COMMITTEES ##############################
	// CREATE ----------------------------------------------------------------
	
	// Create committee - only manager can do this
	private void createCommittee(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, SQLException, IOException {
		
		// Get Values from JSP
		String committeeType = request.getParameter("committeeType");
		System.out.println(committeeType);
		
		if (committeeType.equalsIgnoreCase("management")) {
			
			// Get values from JSP
			String committeeFullName = request.getParameter("committeeFullName");
			String committeePhoneNum = request.getParameter("committeePhoneNum");
			Date committeeBirthDate = Date.valueOf(request.getParameter("committeeBirthDate"));
			String committeeAddress = request.getParameter("committeeAddress");
			int managerID = Integer.parseInt(request.getParameter("managerID"));
			String committeeEmail = request.getParameter("committeeEmail");
			String committeePassword = request.getParameter("committeePassword");
			String managementPosition = request.getParameter("committeePosition");
			
			// Create New Committee Object
			Management newManagement = new Management
			(committeeFullName, committeePhoneNum, committeeBirthDate, committeeAddress, 
			managerID, committeeEmail, committeePassword, managementPosition);
			
			// Send to DAO
			comManagementDAO.createManagement(newManagement);
			
			// Redirect to login page
			response.sendRedirect("committee-list.jsp");
			
		}
		else if (committeeType.equalsIgnoreCase("voluntary")) {
			
			// Get values from JSP
			String committeeFullName = request.getParameter("committeeFullName");
			String committeePhoneNum = request.getParameter("committeePhoneNum");
			Date committeeBirthDate = Date.valueOf(request.getParameter("committeeBirthDate"));
			String committeeAddress = request.getParameter("committeeAddress");
			int managerID = Integer.parseInt(request.getParameter("managerID"));
			String committeeEmail = request.getParameter("committeeEmail");
			String committeePassword = request.getParameter("committeePassword");
			String voluntaryRole = request.getParameter("committeePosition");
			double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
			
			// Create New Committee Object
			Voluntary newVoluntary = new Voluntary
			(committeeFullName, committeePhoneNum, committeeBirthDate, committeeAddress, 
			managerID, committeeEmail, committeePassword, hourlyRate, voluntaryRole);
			
			// Send to DAO
			comVoluntaryDAO.createVoluntary(newVoluntary);
			
			// Redirect to login page
			response.sendRedirect("committee-list.jsp");
		}
		
	}
	
	// ############################## MANAGEMENT ##############################
	
	// UPDATE ----------------------------------------------------------------
	
	// Update Management (Manager Only)
	private void updateManagement_ManagerOnly(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
		
		// Get values of JSP
		int committeeID = Integer.parseInt("committeID");
		String committeeFullName = request.getParameter("committeeFullName");
		String committeePhoneNum = request.getParameter("committeePhoneNum");
		Date committeeBirthDate = Date.valueOf(request.getParameter("CommitteeBirthDate"));
		String committeeAddress = request.getParameter("committeeAddress");
		int managerID = Integer.parseInt(request.getParameter("managerID"));
		String committeeEmail = request.getParameter("committeeEmail");
		String committeePassword = request.getParameter("committeePassword");
		String managementPosition = request.getParameter("managementPosition");
		
		// Create Management Object
		Management existingManagement = new Management
	    (committeeID, committeeFullName, committeePhoneNum, committeeBirthDate, committeeAddress, 
	    managerID, committeeEmail, committeePassword, managementPosition);
		
		// Send to DAO
		comManagementDAO.updateManagement_ManagerOnly(existingManagement);
		
		// Redirect back to view account
		response.sendRedirect("committee-list.jsp");
		
	}
	
	// Update Management Account (Normal Management Account Update)
	private void updateManagement(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
			
		// Get values of JSP
		int committeeID = Integer.parseInt("committeID");
		String committeeFullName = request.getParameter("committeeFullName");
		String committeePhoneNum = request.getParameter("committeePhoneNum");
		Date committeeBirthDate = Date.valueOf(request.getParameter("CommitteeBirthDate"));
		String committeeAddress = request.getParameter("committeeAddress");
		String committeeEmail = request.getParameter("committeeEmail");
		String committeePassword = request.getParameter("committeePassword");
			
		// Create Management Object
		Management existingManagement = new Management();
		
		existingManagement.setCommitteeID(committeeID);
		existingManagement.setCommitteeFullName(committeeFullName);
		existingManagement.setCommitteePhoneNum(committeePhoneNum);
		existingManagement.setCommitteeBirthDate(committeeBirthDate);
		existingManagement.setCommitteeAddress(committeeAddress);
		existingManagement.setCommitteeEmail(committeeEmail);
		existingManagement.setCommitteePassword(committeePassword);
			
		// Send to DAO
		comManagementDAO.updateManagement(existingManagement);
			
		// Redirect back to view account
		response.sendRedirect("committee-account.jsp");
			
		}
	
	// DELETE ---------------------------------------------------------------- 
	
	// Delete Management Account
	private void deleteManagement(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
			
		// Get values from JSP
		int committeeID = Integer.parseInt(request.getParameter("committeeID"));
					
		// Send to DAO
		comManagementDAO.deleteManagement(committeeID);;
					
		// Redirect to home page
		response.sendRedirect("homepage.html");
	}
	
	// ############################## VOLUNTARY ##############################
	
	// UPDATE --------------------------------------------------------------
	
	// Update Voluntary (Manager Only)
	private void updateVoluntary_ManagerOnly(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
	
		// Get values
		int committeeID = Integer.parseInt("committeID");
		String committeeFullName = request.getParameter("committeeFullName");
		String committeePhoneNum = request.getParameter("committeePhoneNum");
		Date committeeBirthDate = Date.valueOf(request.getParameter("CommitteeBirthDate"));
		String committeeAddress = request.getParameter("committeeAddress");
		int managerID = Integer.parseInt(request.getParameter("managerID"));
		String committeeEmail = request.getParameter("committeeEmail");
		String committeePassword = request.getParameter("committeePassword");
		double hourlyRate = Double.parseDouble("hourlyRate");
		String voluntaryPosition = request.getParameter("voluntaryPosition");
		
		// Create Voluntary Object
		Voluntary existingVoluntary = new Voluntary
		(committeeID, committeeFullName, committeePhoneNum, committeeBirthDate, committeeAddress,
		managerID, committeeEmail, committeePassword, hourlyRate, voluntaryPosition);
		
		// Send to DAO
		comVoluntaryDAO.updateVoluntary_ManagerOnly(existingVoluntary);
		
		// Redirect back to view account
		session.setAttribute("committeeID", committeeID);
		response.sendRedirect("committee-list.jsp");
		
	}	
	
	// Update Voluntary Account (Normal)
	private void updateVoluntary(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
	
		// Get values
		int committeeID = Integer.parseInt("committeID");
		String committeeFullName = request.getParameter("committeeFullName");
		String committeePhoneNum = request.getParameter("committeePhoneNum");
		Date committeeBirthDate = Date.valueOf(request.getParameter("CommitteeBirthDate"));
		String committeeAddress = request.getParameter("committeeAddress");
		String committeeEmail = request.getParameter("committeeEmail");
		String committeePassword = request.getParameter("committeePassword");

		
		// Create Voluntary Object
		Voluntary existingVoluntary = new Voluntary();
		
		existingVoluntary.setCommitteeID(committeeID);
		existingVoluntary.setCommitteeFullName(committeeFullName);
		existingVoluntary.setCommitteePhoneNum(committeePhoneNum);
		existingVoluntary.setCommitteeBirthDate(committeeBirthDate);
		existingVoluntary.setCommitteeAddress(committeeAddress);
		existingVoluntary.setCommitteeEmail(committeeEmail);
		existingVoluntary.setCommitteePassword(committeePassword);
		
		// Send to DAO
		comVoluntaryDAO.updateVoluntary_ManagerOnly(existingVoluntary);
		
		// Redirect back to view account
		response.sendRedirect("committee-account.jsp");
		
	}	
	
	// DELETE --------------------------------------------------------------
	
	// Delete Voluntary (Manager Only)
	private void deleteVoluntary(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int committeeID = Integer.parseInt(request.getParameter("committeeID"));
						
		// Send to DAO
		comVoluntaryDAO.deleteVoluntary(committeeID);;
						
		// Redirect to home page
		response.sendRedirect("committee-list.jsp");
	}
	
	// ####### ADDITIONAL METHODS #################
	
	
	
	

}
